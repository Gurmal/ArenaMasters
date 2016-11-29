class CreateFightItems < ActiveRecord::Migration[5.0]
  def change
    create_table :fight_items do |t|
      t.references :fight, foreign_key: true
      t.references :gladiator, foreign_key: true
      t.integer :initiative
      t.integer :hp

      t.timestamps
    end
  end
end
