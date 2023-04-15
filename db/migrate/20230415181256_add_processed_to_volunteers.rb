class AddProcessedToVolunteers < ActiveRecord::Migration[7.0]
  def change
    add_column :volunteers, :processed, :boolean, default: false
  end
end
