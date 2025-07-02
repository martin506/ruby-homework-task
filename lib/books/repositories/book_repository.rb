# frozen_string_literal: true

require_relative '../../common/text_repository'
require_relative '../../../db/models/book'
require_relative '../../common/errors/book_not_found_error'

# Book Repository does memory operations related to books
class BookRepository
  attr_reader :books

  def save(book)
    Book.create({ id: book[:id], name: book[:name], author: book[:author], year: book[:year] })
  end

  def find_by_id(id)
    Book.find(id)
  end

  def find_all
    Book.all
  end
end
