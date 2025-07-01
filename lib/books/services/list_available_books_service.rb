# frozen_string_literal: true

require_relative '../../common/use_case'


# List Available Books Service lists all the books which are not borrowed
class ListAvailableBooksService
  include UseCase

  def initialize(book_repository, taken_book_repository)
    @books = []
    @taken_books = []

    @book_repository = book_repository
    @taken_book_repository = taken_book_repository
  end

  def execute
    @books = @book_repository.find_all

    @books.each do |book|
      taken_book = @taken_book_repository.find_last_by_book_id(book.id)

      puts format(
        "ID: %-5d Name: %-40s Author: %-30s Year: %-4d",
        book.id, book.name, book.author, book.year
      ) unless book_unavailable?(taken_book)
    end
  end

  private

  def book_unavailable?(taken_book)
    return false if taken_book.nil?

    return true if taken_book.returned_at.nil?

    false
  end
end
