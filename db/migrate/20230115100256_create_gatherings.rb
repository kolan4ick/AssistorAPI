class CreateGatherings < ActiveRecord::Migration[7.0]
  def change
    create_table :gatherings do |t|
      t.string :title
      t.string :description
      t.float :sum
      t.datetime :start
      t.datetime :end
      t.boolean :ended, default: false
      t.boolean :verification, default: false
      t.string :link

      t.timestamps
    end
  end
end
