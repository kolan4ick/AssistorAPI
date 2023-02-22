# frozen_string_literal: true

class Volunteers::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  protect_from_forgery with: :null_session

  prepend_before_action :require_no_authentication, only: [:new]

  # GET /resource/sign_in
  def new
    render json: { error: "Volunteer sign in GET request is not allowed", status: 400 }
  end

  # POST /resource/sign_in
  def create

    # add sign in by token
    if params[:auth_token].present?
      pp volunteer = Volunteer.find_by(authentication_token: params[:auth_token])
      if volunteer.present?
        sign_in(volunteer)
        render json: volunteer
        return
      end
    end

    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    render json: current_volunteer
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
