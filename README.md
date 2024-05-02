# Geo Location Importer

* Ruby version 3.1.2

# Overview
This gem empowers seamless geolocation data import from CSV files, leveraging parallel processing for expedited execution. Effortlessly handles large datasets.

# Benchmark

Importing 1 Million record to database in 1 minute and 30 seconds

# Setup

Currently this gem is hosted on a repository, you can provide github repo link

To install, all you need is to add it to your Gemfile:

```
    gem "geo_location_importer", git: [repo], branch: main
```

Then, install it using the below command:

```
    bundle install
```

>This gem requires a table "locations". You need to create a new migration that add this table first:

```
    create_table "locations", force: :cascade do |t|
        t.string "ip_address", null: false
        t.string "country_code"
        t.string "country"
        t.string "city"
        t.float "latitude"
        t.float "longitude"
        t.float "mystery_value"
        t.datetime "created_at", null: false
        t.datetime "updated_at", null: false
      end
```


# Using Import Service


```
GeoLocationImporter::ImportCsv.call(file_path, options = {})
```

> The options are optional


|  | Argument | Required    | Explaination   |
| :---:   | :---:   | :---: | :---: |
|1| file_path | true   | Relative local file path in the code base (string)   |
|2| headers | false   | It can be an array of keys if you want custom headers. It can be used when you have different column names then the headers. You can pass an array of headers as follow inside the header key as second argument like this {headers: [:local_ip_address, :country_code, :country........]}|


Example usage
```
file_path = "#{Rails.public_path}/csv/example.csv"
GeoLocationImporter::ImportCsv.call(file_path)
```
