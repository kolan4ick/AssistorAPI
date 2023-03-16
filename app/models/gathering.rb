class Gathering < ApplicationRecord
  has_many_attached :photos

  has_many_attached :finished_photos

  belongs_to :creator, class_name: 'Volunteer'

  has_many :gathering_user_reviews, dependent: :destroy
  has_many :users, through: :gathering_user_reviews

  has_many :gathering_volunteer_reviews, dependent: :destroy
  has_many :volunteers, through: :gathering_volunteer_reviews
end
