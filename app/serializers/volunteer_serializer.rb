# frozen_string_literal: true

class VolunteerSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :email, :name, :surname, :username, :avatar, :viewed_count, :created_count, :description,
             :created_at, :updated_at, :phone, :verification, :authentication_token, :banned, :trust_level



  def viewed_count
    object.viewed_gatherings.count
  end

  def created_count
    object.created_gatherings.count
  end

  def avatar
    rails_blob_url(object.avatar.variant(resize_to_limit: [200, 200]), expires_in: 10.minutes, disposition: 'inline', signed: true) if object.avatar.attached?
  end
end