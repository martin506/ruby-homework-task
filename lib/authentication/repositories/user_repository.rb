# frozen_string_literal: true

require_relative '../models/user_model'

# User Repository class handles the methods related to user data
class UserRepository
  attr_reader :users

  def initialize
    @users = []
  end

  def create?(username, password)
    users.find { |user| user.username == username }
    return false unless users.empty?

    existing_user = User.new(username, password)
    @users << existing_user
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
