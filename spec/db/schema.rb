# frozen_string_literal: true

ActiveRecord::Schema.define(version: 1) do
  create_table 'locations', force: :cascade do |t|
    t.string 'ip_address', null: false
    t.string 'country_code'
    t.string 'country'
    t.string 'city'
    t.float 'latitude'
    t.float 'longitude'
    t.float 'mystery_value'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
