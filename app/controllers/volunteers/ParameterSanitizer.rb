# frozen_string_literal: true

class Volunteers::ParameterSanitizer < Devise::ParameterSanitizer
  def initialize(*)
    super
    permit(:sign_up, keys: [:name, :surname, :username, :description, :phone, :email, :password, :password_confirmation])
    permit(:account_update, keys: [:name, :surname, :username, :description, :phone, :email, :password, :password_confirmation, :current_password])
    permit(:sign_in, keys: [:login, :password])
  end
end