class ChangeVolunteersTrustLevel < ActiveRecord::Migration[7.0]
  def change
    change_column :volunteers, :trust_level, :integer, default: 0
  end
end
