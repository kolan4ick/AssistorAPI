class FavouriteGathering < ApplicationRecord
  belongs_to :gathering

  belongs_to :favouritable, polymorphic: true

  validates_uniqueness_of :favouritable_id, scope: [:favouritable_type, :gathering_id]
end
