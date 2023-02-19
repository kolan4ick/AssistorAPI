# frozen_string_literal: true

class ApiController < ActionController::API
  include AuthorizationHelper

  def index
    render json: { message: 'Welcome to the API.' }
  end
end
