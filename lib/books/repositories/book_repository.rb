# frozen_string_literal: true

require_relative '../../common/text_repository'
require_relative '../../common/errors/book_is_borrowed_error'
require_relative '../../common/errors/not_your_book_error'

# Book Repository does memory operations related to books
class BookRepository
  attr_reader :books

  def initialize(books_text_repository)
    @books = {}
    @borrowed_books = []
    @books_text_repository = books_text_repository

    data = @books_text_repository.read

    data.each_line do |line|
      line_info = line.split(' ')
      @borrowed_books << [line_info[0], line_info[1]]
    end
  end

  def save(id, book)
    books[id] = book
  end

  def find(id)
    books[id]
  end

  def take_book(id, username)
    raise BookIsBorrowedError, 'Book is already borrowed' if borrowed?(id)

    @borrowed_books << [id, username]

    @books_text_repository.write("#{id} #{username}")

    @books[id]
  end

  def return_book(id, username)
    raise BookIsBorrowedError, 'the book should first be borrowed if you want to return it' unless borrowed?(id)

    result = @borrowed_books.delete([id, username])

    if result
      handle_delete_from_file
      result
    else
      raise NotYourBookError, 'You have not borrowed this book yet'
    end
  end

  def borrowed?(id)
    @borrowed_books.each do |book|
      return true if book[0] == id
    end

    false
  end

  def handle_delete_from_file
    @books_text_repository.delete
    @borrowed_books.each { |book| @books_text_repository.write("#{book[0]} #{book[1]}\n") }
  end
end
