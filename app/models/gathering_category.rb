class GatheringCategory < ApplicationRecord
  has_many :gatherings, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
end
