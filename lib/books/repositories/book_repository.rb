# frozen_string_literal: true

require_relative '../../common/text_repository'
require_relative '../../../db/models/book'
require_relative '../../common/errors/book_not_found_error'

# Book Repository does memory operations related to books
class BookRepository
  attr_reader :books

  def save(book)
    new_book = Book.new
    new_book.id = book.id
    new_book.name = book.title
    new_book.author = book.author
    new_book.year =  book.year

    Book.save(new_book)
  end

  def find_by_id(id)
    book = Book.where({ id: id })
    raise BookNotFoundError unless book
    book
  end

  def find_all
    Book.all
  end
end
