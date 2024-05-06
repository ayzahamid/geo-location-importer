require 'bundler/setup'

# Load the gem
require 'geo_location_importer'

# Load Test Helpers
require 'rspec'
require 'factory_bot'

# Load support
Dir['./spec/support/**/*.rb'].each do |filename|
  require filename
end

RSpec.configure do |config|
  config.include DatabaseSupport, db: true
  config.include FactoryBot::Syntax::Methods

  config.around(:each, db: true) do |example|
    with_clean_database do
      example.call
    end
  end

  config.before(:suite) do
    DatabaseSupport.with_clean_database do
      FactoryBot.lint
    end
  end
end
