# frozen_string_literal: true

require 'csv'
require_relative '../../common/use_case_module'

# ReadBooksFromFileService reads data from csv file
class ReadBooksFromFileService
  include(UseCaseModule)
  def initialize(books_repository)
    @books_repository = books_repository
  end

  def execute
    CSV.foreach('./data/books.csv') do |row|
      puts row.inspect
    end
  end
end
