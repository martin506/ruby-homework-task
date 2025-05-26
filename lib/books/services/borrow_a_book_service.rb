# frozen_string_literal: true

require_relative '../../common/use_case_module'

class BorrowABookService
  include UseCaseModule

  def initialize(book_repository)
    @book_repository = book_repository
  end

  def execute(book_id, username)
    @book_repository.take_book(book_id, username)
  end
end
