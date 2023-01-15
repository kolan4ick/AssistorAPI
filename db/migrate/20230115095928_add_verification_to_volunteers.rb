class AddVerificationToVolunteers < ActiveRecord::Migration[7.0]
  def change
    add_column :volunteers, :verification, :boolean
  end
end
