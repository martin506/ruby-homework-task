# frozen_string_literal: true

require 'csv'
require_relative '../../common/use_case'

# ReadBooksFromFileService reads data from csv file
class ReadBooksFromFileService
  include(UseCase)

  def initialize(books_repository)
    @books_repository = books_repository
  end

  def execute
    CSV.foreach('./data/books.csv') do |row|
      if row[0] != 'Book ID'
        begin
          @books_repository.find_by_id(row[0])
        rescue ActiveRecord::RecordNotFound
          @books_repository.save({ id: row[0].to_i, name: row[1], author: row[2], year: row[3].to_i })
        end
      end
    end
  end
end
