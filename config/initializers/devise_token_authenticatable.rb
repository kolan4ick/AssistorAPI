Devise::TokenAuthenticatable.setup do |config|
  # enables the expiration of a token after a specified amount of time,
  # requires an additional field on the model: `authentication_token_created_at`
  # defaults to nil
  config.token_expires_in = 2.weeks

  # enable reset of the authentication token before the model is saved,
  # defaults to false
  # config.should_reset_authentication_token = true
  #
  # enables the setting of the authentication token - if not already - before the model is saved,
  # defaults to false
  # config.should_ensure_authentication_token = true
end