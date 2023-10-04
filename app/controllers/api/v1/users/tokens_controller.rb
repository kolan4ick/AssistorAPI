class Api::V1::Users::TokensController < Devise::Api::TokensController

  def sign_in
    super
  end

  private

  def sign_up_params
    params.permit(:name, :surname, :username, :email, *resource_class.authentication_keys,
                  *::Devise::ParameterSanitizer::DEFAULT_PERMITTED_ATTRIBUTES[:sign_up]).to_h
  end

  def sign_in_params
    params.permit(:email, *resource_class.authentication_keys,
                  *::Devise::ParameterSanitizer::DEFAULT_PERMITTED_ATTRIBUTES[:sign_in]).to_h
  end
end