# frozen_string_literal: true

require_relative './books/repositories/book_repository'
require_relative './books/services/read_books_from_file_service'
require_relative './authentication/repositories/user_repository'
require_relative './authentication/services/login_service'
require_relative './authentication/services/register_service'
require_relative './common/text_repository'
require_relative './authentication/services/authenticate_service'

require_relative './books/services/list_available_books_service'
require_relative './books/services/borrow_a_book_service'
require_relative './books/services/return_a_book_service'

# Runs the whole online library program
class OnlineLibraryRunner
  def initialize
    @user = ''

    @user_text_repository = TextRepository.new('./data/users.txt')
    @book_text_repository = TextRepository.new('./data/taken_books.txt')

    @book_repository = BookRepository.new(@book_text_repository)
    @user_repository = UserRepository.new(@user_text_repository)

    @read_books_from_file_service = ReadBooksFromFileService.new(@book_repository)
    @login_service = LoginService.new(@user_repository)
    @register_service = RegisterService.new(@user_repository)
    @authentication_service = AuthenticateService.new(@login_service, @register_service)

    @list_available_books_service = ListAvailableBooksService.new(@book_repository)
    @borrow_a_book_service = BorrowABookService.new(@book_repository)
    @return_a_book_service = ReturnABookService.new(@book_repository)
  end

  def run
    @read_books_from_file_service.execute

    @user = @authentication_service.execute
    puts @user.inspect

    loop do
      action = get_user_library_action
      break unless start_library_action(action)
    end
  end

  def get_user_library_action
    puts '================================================================='
    puts 'Welcome to the Online Library App! These are the possible actions'
    puts '(1) - list all the available books'
    puts '(2) - borrow one book from the list by its id'
    puts '(3) - return a borrowed book'
    puts '(4) - exit the application'

    action = gets.chomp
    puts '================================================================='
    action
  end

  def start_library_action(action)
    result = ''

    case action
    when '1'
      @list_available_books_service.execute
    when '2'
      puts 'which book do you want to borrow?'
      book_id = gets.chomp

      result = @borrow_a_book_service.execute(book_id, @user.username)
      puts 'this book cannot be borrowed because it is already borrowed' unless result
      puts 'echhh... take it *reluctantly gives you the book*' if result
    when '3'
      puts 'which book do you want to return?'
      book_id = gets.chomp

      result = @return_a_book_service.execute(book_id, @user.username)
      puts 'this book cannot be returned by you or it is not borrowed yet' unless result
      puts 'finally! been waiting for this one' if result
    when '4'
      result = false
    else
      result = 'wrong input'
    end

    result
  end
end



