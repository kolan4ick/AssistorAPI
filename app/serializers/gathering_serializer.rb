# frozen_string_literal: true

class GatheringSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title, :description, :sum, :start, :end, :ended, :verification, :link, :photos,
             :finished_photos, :created_at, :updated_at, :creator_id, :gathering_category_id

  def photos
    object.photos.map { |photo| rails_blob_url(photo.blob, expires_in: 10.minutes, disposition: 'inline', signed: true) }
  end

  def finished_photos
    object.finished_photos.map { |photo| rails_blob_url(photo.blob, expires_in: 10.minutes, disposition: 'inline', signed: true) }
  end
end