class CreateGatheringViews < ActiveRecord::Migration[7.0]
  def change
    create_table :gathering_views do |t|
      t.integer :gathering_id
      t.references :viewer, polymorphic: true, null: false

      t.timestamps
    end
  end
end
