class AddProcessedToGatherings < ActiveRecord::Migration[7.0]
  def change
    add_column :gatherings, :processed, :boolean, default: false
  end
end
