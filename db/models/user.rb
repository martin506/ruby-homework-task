require 'active_record'

class User < ActiveRecord::Base
  has_many :taken_books
  has_many :books, through: :taken_books
end