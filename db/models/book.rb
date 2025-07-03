require 'active_record'

class Book < ActiveRecord::Base
  has_many :taken_books
  has_many :users, through: :taken_books
end