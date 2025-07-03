require_relative '../db_setup'
require_relative './migrations/create_users'
require_relative './migrations/create_books'
require_relative './migrations/create_taken_books'

class MigrationsRunner
  def run
    CreateUsers.new.change
    CreateBooks.new.change
    CreateTakenBooks.new.change
  end
end
