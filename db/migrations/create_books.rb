require 'active_record'
require_relative '../../db_setup'

class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books, if_not_exists: true, id: false do |t|
      t.primary_key :id
      t.string :name
      t.string :author
      t.numeric :year
      t.timestamps
    end
  end
end
