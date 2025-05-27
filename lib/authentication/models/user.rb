# frozen_string_literal: true

# domain class User saved user model
class User
  attr_accessor :username, :password

  def initialize(username, password)
    @username = username
    @password = password
  end
end
