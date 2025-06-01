# db/migrate/003_create_taken_books.rb
require 'active_record'

class CreateTakenBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :taken_books do |t|
      t.references :user, foreign_key: true, null: false
      t.references :book, foreign_key: true, null: false
      t.datetime :taken_at, null: false
      t.datetime :returned_at
      t.timestamps
    end
  end
end