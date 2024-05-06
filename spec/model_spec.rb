# frozen_string_literal: true

require 'spec_helper'
require 'debug'

describe GeoLocationImporter::Location, aggregate_failures: true, db: true do
  describe 'search_location' do
    let!(:location1) { create(:location, ip_address: '192.168.1.1') }
    let!(:location2) { create(:location, ip_address: '10.0.0.1') }
    let!(:location3) { create(:location, ip_address: '172.16.0.1') }

    it 'returns the location with the specified IP address' do
      found_location = GeoLocationImporter::Location.search_location('192.168.1.1')
      expect(found_location).to eq(location1)
    end

    it 'returns nil if no location found with the specified IP address' do
      found_location = GeoLocationImporter::Location.search_location('255.255.255.255')

      expect(found_location).to be_nil
    end
  end
end
