# frozen_string_literal: true

module GeoLocationImporter
  class Location < ActiveRecord::Base
    scope :find_by_ip_address, ->(ip_address) { find_by(ip_address: ip_address) }
  end
end
