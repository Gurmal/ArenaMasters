class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :scheduledDate
      t.datetime :runDate

      t.timestamps
    end
  end
end
