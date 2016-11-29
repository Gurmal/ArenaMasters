class CreateFights < ActiveRecord::Migration[5.0]
  def change
    create_table :fights do |t|
      t.references :event, foreign_key: true
      t.integer :sequence
      t.string :winner
      t.boolean :complete

      t.timestamps
    end
  end
end
