module AuthorizationHelper
  include ActionController::HttpAuthentication::Token::ControllerMethods
  # returns true/false
  def authenticate!
    if current_user || current_volunteer
      true
    else
      authenticate_user! || authenticate_volunteer!
    end
  end
end