# frozen_string_literal: false

# UseCase module is going to be used by all services in order to adhere to single responsibility
module UseCase
  def execute
    raise NotImplementedError
  end
end
