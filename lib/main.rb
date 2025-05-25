# frozen_string_literal: true

require_relative './books/repositories/book_repository'
require_relative './books/services/read_books_from_file_service'
require_relative './authentication/repositories/user_repository'
require_relative './authentication/services/login_service'
require_relative './authentication/services/register_service'


book_repository = BookRepository.new
user_repository = UserRepository.new

read_books_from_file_service = ReadBooksFromFileService.new(book_repository)
login_service = LoginService.new(user_repository)
register_service = RegisterService.new(user_repository)

#read_books_from_file_service.execute
register_service.execute('martynas', '123')
user = login_service.execute('martynas', '123')
puts user.inspect


register_service.execute('martynas', '1233')
user = login_service.execute('martynas', '1233')
puts user.inspect

