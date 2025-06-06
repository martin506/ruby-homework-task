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
    taken_books = @taken_book_repository.find_all

    books.each do |book|
      puts `#{book.id} #{book.name} #{book.author} #{book.year}`
    end
  end

  private

  def check_availability(book)
    @taken_books.each do |taken_book|
      return false if taken_book.book == book
    end
  end
end
