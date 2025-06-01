# db/migrate/001_create_users.rb
require 'active_record'

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.timestamps
    end
  end
end
