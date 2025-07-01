# frozen_string_literal: true

require_relative '../../common/errors/user_not_found_error'

# Authentication Service handles the functions related to authentication
class AuthenticateService
  include UseCase
  def initialize(user_repository)
    @user_repository = user_repository
  end

  def execute
    until @is_logged_in
      user_input = authenticate_input
      user = authenticate_execute_logic(user_input[:auth_choice], user_input[:name], user_input[:password])

      return user if user
    end
  end

  private

  def authenticate_input
    puts '================================================================='
    puts 'do you want to login or to register: (1) - login,  (2) - register'
    auth_choice = gets.chomp
    puts 'please write your name'
    name = gets.chomp
    puts 'please write your password'
    password = gets.chomp

    puts '================================================================='

    { auth_choice: auth_choice, name: name, password: password }
  end

  def authenticate_execute_logic(auth_choice, name,  password)
    user = false
    case auth_choice
    when '1'
      user = login(name, password)
      if user
        @is_logged_in = true
        user
      end
    when '2'
      register(name, password)
      user = false
    else
      puts 'wrong input'
    end
  end

  def login(name, password)
    begin
      existing_user = @user_repository.find_by_name(name)
      puts existing_user.inspect

      existing_user if existing_user && existing_user.password == password
    rescue UserNotFoundError => ex
      puts ex.message
    end
  end

  def register(name, password)
    begin
      @user_repository.create!(name, password)

    rescue UserAlreadyExistsError => ex
      puts ex.message
    end
  end
end
