class GatheringCategory < ApplicationRecord
  has_many :gatherings, dependent: :destroy
end
