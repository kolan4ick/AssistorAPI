class GatheringView < ApplicationRecord
  belongs_to :gathering
  belongs_to :viewer, polymorphic: true

  validates_uniqueness_of :viewer_id, scope: [:viewer_type, :gathering_id]
end
