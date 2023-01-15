class AddGatheringCategoryIdToGathering < ActiveRecord::Migration[7.0]
  def change
    add_column :gatherings, :gathering_category_id, :integer
  end
end
