# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GeoLocationImporter::ImportCsv do
  describe '#import' do
    let(:file_path) { 'spec/fixtures/data_dump.csv' }

    context 'Passing custom headers' do
      it 'raise error when provided invalid headers' do
        expect { described_class.call(file_path, %i[ip_address country_code]) }
          .to raise_error(StandardError, 'Options must be hash, please pass {headers: []}')
      end

      it 'import data when provided correct headers' do
        described_class.call(file_path,
                             headers: %i[ip_address country_code country city latitude longitude mystery_value])
      end
    end

    context 'Importing csv' do
      it 'successfully import data from a csv' do
        result = described_class.call(file_path)
        expect(result).to be(:ok)
      end

      it 'show statistics for the imported records' do
        expect do
          described_class.call(file_path)
        end.to output(/Total accepted records: 9\nTotal rejected records: 2/).to_stdout
      end
    end
  end
end
