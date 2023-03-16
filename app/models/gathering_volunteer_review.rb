class GatheringVolunteerReview < ApplicationRecord
  belongs_to :gathering

  belongs_to :volunteer
end
