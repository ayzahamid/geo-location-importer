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

      Parallel.map(chunks, progress: 'Starting Import', in_processes: 5) do |chunk|
        worker(chunk)
      end
    end

    class << self
      def call(file, opts = {})
        new(file, opts).import
      end
    end

    private

    def worker(array_of_hashes)
      ActiveRecord::Base.connection.reconnect!

      filtered_array = array_of_hashes.select { |location| IPAddress.valid? location[:ip_address] }

      Location.import(filtered_array)
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
