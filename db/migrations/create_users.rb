# db/migrate/001_create_users.rb
require 'active_record'
require_relative '../../db_setup'

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, if_not_exists: true do |t|
      t.string :name
      t.string :password
      t.timestamps
    end
  end
end
