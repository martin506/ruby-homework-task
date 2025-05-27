# frozen_string_literal: true

require_relative '../../common/use_case'


# List Available Books Service lists all the books which are not borrowed
class ListAvailableBooksService
  include UseCase

  def initialize(book_repository)
    @book_repository = book_repository
  end

  def execute
    @book_repository.books.each_with_object({}) do |(book_id, book)|
      puts "#{book_id} #{book.name} #{book.author} #{book.release_year}" unless @book_repository.borrowed?(book_id)
    end
  end
end
