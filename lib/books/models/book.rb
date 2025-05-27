# frozen_string_literal: true

# Book domain class which represents properties which can be found in a book
class Book
  attr_accessor :name, :author, :release_year

  def initialize(name, author, release_year)
    @name = name
    @author = author
    @release_year = release_year
  end
end
