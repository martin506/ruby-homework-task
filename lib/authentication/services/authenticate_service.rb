# frozen_string_literal: true

# Authentication Service handles the functions related to authentication
class AuthenticateService
  include UseCaseModule
  def initialize(login_service, register_service)
    @login_service = login_service
    @register_service = register_service
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
      user = @login_service.execute(username, password)
      if user
        @is_logged_in = true
        user
      end
    when '2'
      return_value = @register_service.execute(username, password)
      puts 'user already exists' unless return_value
    else
      puts 'wrong input'
    end
  end
end
