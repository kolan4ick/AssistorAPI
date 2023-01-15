class AddTrustLevelToVolunteers < ActiveRecord::Migration[7.0]
  def change
    add_column :volunteers, :trust_level, :integer
  end
end
