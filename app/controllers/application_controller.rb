class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  protected

  def devise_parameter_sanitizer
    if resource_class == User
      Users::ParameterSanitizer.new(User, :user, params)
    elsif resource_class == Volunteer
      Volunteers::ParameterSanitizer.new(Volunteer, :volunteer, params)
    else
      super # Use the default one
    end
  end
end
