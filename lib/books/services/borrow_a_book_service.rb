# frozen_string_literal: true

require_relative '../../common/use_case'

# Borrow a book service handles logic behind borrowing a book
class BorrowABookService
  include UseCase

  def initialize(book_repository)
    @book_repository = book_repository
  end

  def execute(book_id, username)
    begin
      @book_repository.take_book(book_id, username)

    rescue BookIsBorrowedError => ex
      puts ex.message
    end
  end
end
