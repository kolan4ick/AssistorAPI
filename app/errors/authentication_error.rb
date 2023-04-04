# frozen_string_literal: true
class AuthenticationError < StandardError
  def initialize(message = 'Помилка авторизації')
    super(message)
  end
end
