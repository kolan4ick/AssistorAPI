# frozen_string_literal: true

class GatheringSerializer < ActiveModel::Serializer
  require 'capybara'
  include Rails.application.routes.url_helpers

  attributes :id, :title, :description, :sum, :start, :end, :ended, :verification, :link, :photos,
             :finished_photos, :created_at, :updated_at, :creator_id, :gathering_category_id, :is_favourite, :is_editable, :already_gathered

  def photos
    object.photos.map { | photo | rails_blob_url(photo.variant(resize_to_limit: [1170, 2532]), disposition: 'inline', signed: true) }
  end

  def finished_photos
    object.finished_photos.map { | photo | rails_blob_url(photo.variant(resize_to_limit: [1170, 2532]), disposition: 'inline', signed: true) }
  end

  def is_favourite
    favouritable = scope

    favouritable.favourites.include?(object)
  end

  def is_editable
    object.creator == scope
  end

  def already_gathered
    Capybara.default_driver = :selenium

    # Open the page
    session = Capybara::Session.new(:selenium)
    session.visit(object.link)

    # Remove white spaces and parse to float
    session.find('.stats-data-value').text.gsub(/\s+/, '').to_f
  end
end