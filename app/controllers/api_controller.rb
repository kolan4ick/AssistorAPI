# frozen_string_literal: true

class ApiController < ActionController::API
  require_relative '../errors/authentication_error'

  def index
    render json: { message: 'Welcome to the API.' }
  end

  private

  # Method to authenticate user or volunteer by token
  def authenticate!
    if params[:auth_token].present?
      authenticatable = User.find_by(authentication_token: params[:auth_token]) || Volunteer.find_by(authentication_token: params[:auth_token])
      if authenticatable.present?
        # reset authentication_token if current token is expired
        authenticatable.reset_authentication_token! if authenticatable.expired_authentication_token?

        sign_in(authenticatable)
        return
      end
    end
    raise AuthenticationError.new("Ви не авторизовані")
  end

  # Method to authenticate volunteer by token
  def volunteer_authenticate!
    if params[:auth_token].present?
      volunteer = Volunteer.find_by(authentication_token: params[:auth_token])
      if volunteer.present?
        # reset authentication_token if current token is expired
        volunteer.reset_authentication_token! if volunteer.expired_authentication_token?

        sign_in(volunteer)
        return
      end
    end
    raise AuthenticationError.new("Ви не авторизовані")
  end
end
