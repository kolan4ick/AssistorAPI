class AddBannedToVolunteers < ActiveRecord::Migration[7.0]
  def change
    add_column :volunteers, :banned, :boolean, default: false
  end
end
