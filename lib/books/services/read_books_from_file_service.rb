# frozen_string_literal: true

require 'csv'
require_relative '../../common/use_case'
require_relative '../models/book'

# ReadBooksFromFileService reads data from csv file
class ReadBooksFromFileService
  include(UseCase)
  def initialize(books_repository)
    @books_repository = books_repository
  end

  def execute
    CSV.foreach('./data/books.csv') do |row|
      if row[0] != 'Book ID'
        book = Book.new(row[1], row[2], row[3])
        @books_repository.save(row[0], book)
      end
    end
  end
end
