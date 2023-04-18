class AddGatheredSumToGatherings < ActiveRecord::Migration[7.0]
  def change
    add_column :gatherings, :gathered_sum, :float, default: 0.0
  end
end
