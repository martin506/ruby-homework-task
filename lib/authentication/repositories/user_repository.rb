# frozen_string_literal: true

require_relative '../../../db/models/user'
require_relative '../../common/errors/user_already_exists_error'

# User Repository class handles the methods related to user data
class UserRepository
  attr_reader :users

  def create!(name, password)
    user = find_by_name(name)

    raise UserAlreadyExistsError, 'User with such name already exists' if user

    User.create({ name: name, password: password })
    true
  end

  def find_by_name(name)
      User.find_by(name: name)
  end
end
