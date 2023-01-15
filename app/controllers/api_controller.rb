# frozen_string_literal: true

class ApiController < ActionController::API
  def authenticate!
    if @current_user == current_admin
      :authenticate_admin!
    elsif @current_user == current_pupil
      :authenticate_pupil
    elsif @current_user == current_teacher
      :authenticate_teacher
    end
  end
end
