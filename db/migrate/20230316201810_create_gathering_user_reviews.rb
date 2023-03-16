class CreateGatheringUserReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :gathering_user_reviews do |t|
      t.integer :gathering_id
      t.integer :user_id

      t.timestamps
    end
  end
end
