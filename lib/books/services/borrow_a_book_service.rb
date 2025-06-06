# frozen_string_literal: true

require_relative '../../common/use_case'
require_relative '../../common/errors/book_is_borrowed_error'

# Borrow a book service handles logic behind borrowing a book
class BorrowABookService
  include UseCase

  def initialize(taken_book_repository, book_repository)
    @taken_book_repository = taken_book_repository
  end

  def execute(book_id, username)
    begin
      taken_book = @taken_book_repository.find_last_by_username_and_book_id(username, book_id)

      raise BookIsBorrowedError  if taken_book.returned_at == nil

      @taken_book_repository.save_new_taken_book(username, book_id)
    rescue BookIsBorrowedError => ex
      puts ex.message
    end
  end
end
