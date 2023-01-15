class Gathering < ApplicationRecord
  belongs_to :volunteer

  has_one_attached :photos

  has_one_attached :finished_photos

  belongs_to :gathering_category
end
