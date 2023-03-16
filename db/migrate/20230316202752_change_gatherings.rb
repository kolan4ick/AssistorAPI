class ChangeGatherings < ActiveRecord::Migration[7.0]
  def change
    rename_column :gatherings, :volunteer_id, :creator_id
  end
end
