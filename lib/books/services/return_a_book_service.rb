# frozen_string_literal: true

require_relative '../repositories/book_repository'

# Return a book service handles the logic behind
class ReturnABookService
  include UseCaseModule

  def initialize(book_repository)
    @book_repository = book_repository
  end

  def execute(book_id, username)
    @book_repository.return_book(book_id, username)
  end
end
