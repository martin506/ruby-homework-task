require 'active_record'

class TakenBook < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
end