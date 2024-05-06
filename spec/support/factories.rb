require 'faker'

FactoryBot.define do
  factory :location, class: 'GeoLocationImporter::Location' do
    ip_address { Faker::Internet.ip_v4_address }
    country_code { Faker::Address.country_code }
    country { Faker::Address.country }
    city { Faker::Address.city }
    latitude { Faker::Number.decimal(l_digits: 2) }
    longitude { Faker::Number.decimal(l_digits: 2) }
    mystery_value { rand }
  end
end
