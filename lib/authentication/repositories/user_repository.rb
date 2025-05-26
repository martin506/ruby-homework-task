# frozen_string_literal: true

require_relative '../models/user_model'

# User Repository class handles the methods related to user data
class UserRepository
  attr_reader :users

  def initialize(users_text_repository)
    @users = []
    @users_text_repository = users_text_repository
    data = @users_text_repository.read

    data.each_line do |line|
      user_info = line.split(' ')
      @users << User.new(user_info[0], user_info[1])
    end
  end

  def create?(username, password)
    users.each do |user|
      return false if user.username == username
    end


    @users << User.new(username, password)
    @users_text_repository.write("#{username} #{password}")
    true
  end

  def login(username, password)
    @users.each do |user|
      return user if user.username == username && user.password == password
    end

    false
  end

  def find_by_username(username)
    @users.each do |user|
      return user if user.username == username
    end

    false
  end
end
