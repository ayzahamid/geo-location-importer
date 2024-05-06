# frozen_string_literal: true

require 'smarter_csv'
require 'parallel'
require 'activerecord-import'
require 'ipaddress'
require 'geo_location_importer/models/location'

module GeoLocationImporter
  class ImportCsv
    attr_reader :file, :headers

    def initialize(file, opts = {})
      @file = file
      @headers = opts[:headers] || {}
    end

    def import
      options = {
        chunk_size: 1000,
        remove_empty_values: false,
        remove_zero_values: false,
        silence_missing_keys: false
      }.merge(custom_headers)

      chunks = SmarterCSV.process(@file, options)

      total_accepted_count = 0
      total_rejected_count = 0
      mutex = Mutex.new

      Parallel.map(chunks, progress: 'Starting Import', in_threads: 5) do |chunk|
        accepted_count, rejected_count = worker(chunk)
        mutex.synchronize do
          total_accepted_count += accepted_count
          total_rejected_count += rejected_count
        end
      end

      puts "Total accepted records: #{total_accepted_count}"
      puts "Total rejected records: #{total_rejected_count}"
    end

    class << self
      def call(file, opts = {})
        new(file, opts).import
      end
    end

    private

    def worker(array_of_hashes)
      ActiveRecord::Base.connection.reconnect!

      accepted_records = array_of_hashes.select { |location| IPAddress.valid?(location[:ip_address]) }
      rejected_records_count = array_of_hashes.count - accepted_records.count

      Location.import(accepted_records)

      [accepted_records.count, rejected_records_count]
    end

    def custom_headers
      return {} if @headers.empty?

      raise StandardError, 'Header must be hash' unless headers.is_a?(Array)

      {
        headers_in_file: false,
        user_provided_headers: @headers
      }
    end
  end
end
