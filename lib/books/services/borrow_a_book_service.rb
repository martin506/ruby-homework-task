# frozen_string_literal: true

require_relative '../../common/use_case'
require_relative '../../common/errors/book_is_borrowed_error'

# Borrow a book service handles logic behind borrowing a book
class BorrowABookService
  include UseCase

  def initialize(taken_book_repository)
    @taken_book_repository = taken_book_repository
  end

  def execute(book_id, name)
    begin
      taken_book = @taken_book_repository.find_last_by_book_id(book_id)

      return @taken_book_repository.save_new_taken_book(name, book_id) if taken_book.nil?

      raise BookIsBorrowedError if taken_book.returned_at.nil?

      @taken_book_repository.save_new_taken_book(name, book_id)
    rescue BookIsBorrowedError => ex
      puts ex.message
    end
  end
end
