# frozen_string_literal: true

# Authentication Service handles the functions related to authentication
class AuthenticateService
  include UseCase
  def initialize(user_repository)
    @user_repository = user_repository
  end

  def execute
    until @is_logged_in
      user_input = authenticate_input
      user = authenticate_execute_logic(user_input[:auth_choice], user_input[:username], user_input[:password])

      return user if user
    end
  end

  private

  def authenticate_input
    puts '================================================================='
    puts 'do you want to login or to register: (1) - login,  (2) - register'
    auth_choice = gets.chomp
    puts 'please write your name'
    username = gets.chomp
    puts 'please write your password'
    password = gets.chomp

    puts '================================================================='

    { auth_choice: auth_choice, username: username, password: password }
  end

  def authenticate_execute_logic(auth_choice, username,  password)
    user = false
    case auth_choice
    when '1'
      user = login(username, password)
      if user
        @is_logged_in = true
        user
      end
    when '2'
      register(username, password)
      user = false
    else
      puts 'wrong input'
    end
  end

  def login(username, password)
    begin
      existing_user = @user_repository.find_by_username(username)
      existing_user if existing_user.password == password

    rescue UserNotFoundError => ex
      puts ex.message
    end
  end

  def register(username, password)
    begin
      @user_repository.create!(username, password)

    rescue UserAlreadyExistsError => ex
      puts ex.message
    end
  end
end
