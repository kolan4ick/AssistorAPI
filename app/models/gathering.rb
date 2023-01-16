class Gathering < ApplicationRecord
  belongs_to :volunteer

  has_many_attached :photos

  has_many_attached :finished_photos

  belongs_to :gathering_category
end
