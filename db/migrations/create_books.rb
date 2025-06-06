require 'active_record'

class CreateBook < ActiveRecord::Migration[7.1]
  def change
    create_table :books, if: false do |t|
      t.primary_key :id, :integer
      t.string :name
      t.string :author
      t.numeric :year
      t.timestamps
    end
  end
end