# frozen_string_literal: true

class Volunteers::ParameterSanitizer < Devise::ParameterSanitizer
  def initialize(*)
    super
    permit(:sign_up, keys: [:name, :surname, :login, :description, :phone, :email, :password, :password_confirmation])
    permit(:account_update, keys: [:name, :surname, :login, :description, :phone, :email, :password, :password_confirmation, :current_password])
  end
end