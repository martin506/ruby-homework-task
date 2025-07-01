# frozen_string_literal: true

require_relative '../repositories/book_repository'
require_relative '../../common/errors/book_is_borrowed_error'
require_relative '../../common/errors/not_your_book_error'

# Return a book service handles the logic behind
class ReturnABookService
  include UseCase

  def initialize(taken_book_repository)
    @taken_book_repository = taken_book_repository
  end

  def execute(book_id, name)
    begin
      taken_book = @taken_book_repository.find_last_by_name_and_book_id(name, book_id)

      raise NotYourBookError unless taken_book

      @taken_book_repository.update_returned_at(taken_book)
    rescue NotYourBookError => ex
      puts ex.message
    end
  end
end
