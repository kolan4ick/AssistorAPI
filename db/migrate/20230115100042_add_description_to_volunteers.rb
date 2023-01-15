class AddDescriptionToVolunteers < ActiveRecord::Migration[7.0]
  def change
    add_column :volunteers, :description, :string
  end
end
