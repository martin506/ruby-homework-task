# db_setup.rb
require 'active_record'
require_relative './db/migrate'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.sqlite3'
)

MigrationsRunner.new.run
