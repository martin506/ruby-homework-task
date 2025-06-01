require_relative '../db_setup'
require_relative './migrations/create_users'
require_relative './migrations/create_books'
require_relative './migrations/create_taken_books'

CreateUsers.new.change
