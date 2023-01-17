# frozen_string_literal: true

class Users::ParameterSanitizer < Devise::ParameterSanitizer
  def initialize(*)
    super
    permit(:sign_up, keys: [:name, :surname, :login, :email, :password, :password_confirmation])
    permit(:account_update, keys: [:name, :surname, :login, :email, :password, :password_confirmation, :current_password])
  end
end