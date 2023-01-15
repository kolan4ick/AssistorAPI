class AddNameToVolunteers < ActiveRecord::Migration[7.0]
  def change
    add_column :volunteers, :name, :string
  end
end
