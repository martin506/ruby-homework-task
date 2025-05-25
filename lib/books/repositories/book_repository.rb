# frozen_string_literal: true

# Book Repository does memory operations related to books
class BookRepository
  attr_reader :books

  def initialize
    @books = {}
  end

  def save(id, book)
    books[id] = book
  end

  def find(id)
    books[id]
  end

  def take_book(id)
    books[id].is_borrowed = true
  end

  def return_book(id)
    books[id].is_borrowed = false
  end
end
