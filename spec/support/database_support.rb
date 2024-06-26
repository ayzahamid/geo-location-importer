# Just Rspec helpers for DB
module DatabaseSupport
  def with_clean_database
    database_filename = 'test'
    FileUtils.rm(database_filename) if File.exist?(database_filename)
    ActiveRecord::Base.establish_connection adapter: :postgresql, database: database_filename
    ActiveRecord::Migration.suppress_messages do
      load('spec/db/schema.rb')
    end
    yield
  ensure
    FileUtils.rm(database_filename) if File.exist?(database_filename)
  end

  module_function :with_clean_database
end
