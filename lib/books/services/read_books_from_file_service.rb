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
        @books_repository.save({ id: row[0], title: row[1], author: row[2], year: row[3] })
      end
    end
  end
end
