# frozen_string_literal: true

class VolunteerSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :email, :name, :surname, :username, :avatar, :favourites_count, :description,
             :created_at, :updated_at, :phone, :verification, :authentication_token, :banned, :trust_level

  def favourites_count
    object.favourites.count
  end

  def avatar
    rails_blob_path(object.avatar, expires_in: 10.minutes, disposition: 'inline', signed: true) if object.avatar.attached?
  end
end