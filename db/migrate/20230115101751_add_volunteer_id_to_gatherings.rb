class AddVolunteerIdToGatherings < ActiveRecord::Migration[7.0]
  def change
    add_column :gatherings, :volunteer_id, :integer
  end
end
