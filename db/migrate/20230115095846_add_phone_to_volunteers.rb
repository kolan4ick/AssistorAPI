class AddPhoneToVolunteers < ActiveRecord::Migration[7.0]
  def change
    add_column :volunteers, :phone, :string
  end
end
