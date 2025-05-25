# frozen_string_literal: true

require_relative '../../common/use_case_module'
require_relative '../repositories/user_repository'

# Register service handles the logic behind user registering
class RegisterService
  include(UseCaseModule)

  def initialize(user_repository)
    @user_repository = user_repository
  end

  def execute(username, password)
    @user_repository.create?(username, password)
  end
end
