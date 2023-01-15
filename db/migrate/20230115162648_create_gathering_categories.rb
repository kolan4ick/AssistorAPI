class CreateGatheringCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :gathering_categories do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
