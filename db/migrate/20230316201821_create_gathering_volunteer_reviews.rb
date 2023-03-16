class CreateGatheringVolunteerReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :gathering_volunteer_reviews do |t|
      t.integer :gathering_id
      t.integer :volunteer_id

      t.timestamps
    end
  end
end
