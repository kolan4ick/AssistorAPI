# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  protect_from_forgery with: :null_session

  prepend_before_action :require_no_authentication, only: [:new]

  # GET /resource/sign_in
  def new
    render json: { error: "Users sign in GET request is not allowed" }, status: 400
  end

  # POST /resource/sign_in
  def create

    # add sign in by token
    if params[:auth_token].present?
      user = User.find_by_authentication_token(params[:auth_token])
      if user.present?

        # reset authentication_token if current token is expired
        user.reset_authentication_token! if user.expired_authentication_token?

        sign_in(user)
        render json: user
        return
      end
    end

    begin
      self.resource = warden.authenticate(auth_options)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)

      # reset authentication_token if current token is expired
      resource.reset_authentication_token! if resource.expired_authentication_token?

      yield resource if block_given?
      render json: resource
    rescue
      case warden.message
      when :not_found_in_database
        render json: { error_message: "Такого логіну немає в базі даних!" }, status: 400
      when :invalid
        render json: { error_message: "Невірний пароль!" }, status: 400
      else
        render json: { error_message: "Сталась невідома помилка!" }, status: 400
      end
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
