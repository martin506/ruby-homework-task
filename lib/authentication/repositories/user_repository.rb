# frozen_string_literal: true

require_relative '../../../db/models/user'
require_relative '../../common/errors/user_already_exists_error'
require_relative '../../common/errors/user_not_found_error'

# User Repository class handles the methods related to user data
class UserRepository
  attr_reader :users

  def create!(username, password)
    raise UserAlreadyExistsError, 'User with such username already exists' if find_by_username(username)

    User.create({ username: username, password: password })
    true
  end

  def find_by_username(username)
    user = User.where({ username: username })

    raise UserNotFoundError, 'User with such username was not found' unless user
    user
  end
end
