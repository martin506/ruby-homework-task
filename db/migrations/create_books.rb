require 'active_record'

class CreateBook < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.numeric :year
      t.timestamps
    end
  end
end