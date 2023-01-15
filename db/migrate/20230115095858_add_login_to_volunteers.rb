class AddLoginToVolunteers < ActiveRecord::Migration[7.0]
  def change
    add_column :volunteers, :login, :string
  end
end
