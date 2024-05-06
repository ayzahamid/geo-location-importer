# frozen_string_literal: true

require 'active_record'
require 'debug'
module GeoLocationImporter
  class Location < ActiveRecord::Base
    def self.search_location(ip_address)
      where(ip_address: ip_address).first
    end
  end
end
