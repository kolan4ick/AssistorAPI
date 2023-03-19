class CreateFavouriteGatherings < ActiveRecord::Migration[7.0]
  def change
    create_table :favourite_gatherings do |t|
      t.integer :gathering_id
      t.references :favouritable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
