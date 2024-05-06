# frozen_string_literal: true

require File.expand_path('lib/geo_location_importer/version', __dir__)

Gem::Specification.new do |spec|
  spec.name                   = 'geo_location_importer'
  spec.version                = GeoLocationImporter::VERSION
  spec.author                 = ['Ayza Hamid']
  spec.email                  = ['ayzahamid222@gmail.com']
  spec.summary                = 'A gem that provide csv import functionality'
  spec.description            = 'This gem empowers seamless geolocation data import from CSV files, leveraging parallel
                                 processing for expedited execution. Effortlessly handle large datasets
                                 with optimal performance and accuracy.'
  spec.platform               = Gem::Platform::RUBY
  spec.required_ruby_version  = '>= 3.0.0'

  spec.files = Dir['README.md', 'lib/**/*.rb',
                   'geo_location_importer.gemspec']

  spec.add_dependency 'activerecord-import', '~> 1.6'
  spec.add_dependency 'benchmark', '~> 0.3.0'
  spec.add_dependency 'parallel', '~> 1.11', '>= 1.11.2'
  spec.add_dependency 'smarter_csv', '~> 1.10', '>= 1.10.3'
  spec.add_dependency 'ipaddress', '~> 0.8.3'

  spec.add_development_dependency 'rspec', '~> 3.13'
  spec.add_development_dependency 'rubocop', '~> 1.63', '>= 1.63.4'
  spec.add_development_dependency 'factory_bot', '~> 6.4', '>= 6.4.6'
  spec.add_development_dependency 'faker', '~> 3.3', '>= 3.3.1'
  spec.add_development_dependency 'pg', '~> 1.5', '>= 1.5.5'
  spec.add_development_dependency 'debug', '~> 1.9', '>= 1.9.2'
end
