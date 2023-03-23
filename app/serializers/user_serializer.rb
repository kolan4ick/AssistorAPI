# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :email, :name, :surname, :username, :created_at, :updated_at, :authentication_token, :favourites_count

  def favourites_count
    object.favourites.count
  end
end