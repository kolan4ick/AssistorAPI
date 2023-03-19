class Gathering < ApplicationRecord
  has_many_attached :photos

  has_many_attached :finished_photos

  belongs_to :creator, class_name: 'Volunteer'

  has_many :gathering_views

  has_many :favourite_gatherings
end
