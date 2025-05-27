# frozen_string_literal: true

require_relative '../models/user'
require_relative '../../common/errors/user_already_exists_error'
require_relative '../../common/errors/user_not_found_error'

# User Repository class handles the methods related to user data
class UserRepository
  attr_reader :users

  def initialize(users_text_repository)
    @users ||= []
    @users_text_repository = users_text_repository
    find_all
  end

  def create!(username, password)
    users.each do |user|
      raise UserAlreadyExistsError, 'User with such username already exists' if user.username == username
    end


    @users << User.new(username, password)
    @users_text_repository.write("#{username} #{password}")
    true
  end

  def find_by_username(username)
    @users.each do |user|
      return user if user.username == username
    end

    raise UserNotFoundError, 'User with such username was not found'
  end

  def find_all
    data = @users_text_repository.read

    data.each_line do |line|
      user_info = line.split(' ')
      @users << User.new(user_info[0], user_info[1])
    end
  end
end
