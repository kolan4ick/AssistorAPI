class AddSurnameToVolunteers < ActiveRecord::Migration[7.0]
  def change
    add_column :volunteers, :surname, :string
  end
end
