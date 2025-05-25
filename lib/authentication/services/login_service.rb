# frozen_string_literal: true

require_relative '../repositories/user_repository'
require_relative '../../common/use_case_module'
# Login service handles login logic
class LoginService
  include(UseCaseModule)

  def initialize(user_repository)
    @user_repository = user_repository
  end

  def execute(username, password)
    @user_repository.login(username, password)
  end
end
