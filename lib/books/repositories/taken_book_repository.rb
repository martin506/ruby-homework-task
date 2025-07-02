# frozen_string_literal: true

require_relative '../../../db/models/book'
require_relative '../../../db/models/taken_book'

class TakenBookRepository
  def initialize(book_repository, user_repository)
    @book_repository = book_repository
    @user_repository = user_repository
  end

  def find_last_by_name_and_book_id(name, book_id)
    book = @book_repository.find_by_id(book_id)
    user = @user_repository.find_by_name(name)

    TakenBook.where({ book: book, user: user }).last
  end

  def find_last_by_book_id(book_id)
    TakenBook.where(book_id: book_id).last
  end

  def save_new_taken_book(name, book_id)
    user = @user_repository.find_by_name(name)
    book = @book_repository.find_by_id(book_id)

    TakenBook.create({ book: book, user: user,  taken_at: DateTime.now })
  end

  def update_returned_at(taken_book)
    taken_book.update(returned_at: DateTime.now)
  end

  def find_all
    TakenBook.where(returned_at: nil)
  end
end