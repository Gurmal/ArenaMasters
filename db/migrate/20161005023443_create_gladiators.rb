class CreateGladiators < ActiveRecord::Migration[5.0]
  def change
    create_table :gladiators do |t|
      t.references :team, foreign_key: true
      t.string :name
      t.integer :fightStyle
      t.integer :str
      t.integer :dex
      t.integer :spd
      t.integer :con
      t.integer :chr
      t.integer :intl
      t.date :birth
      t.date :firstfight
      t.date :death
      t.integer :wounds
      t.integer :reputation

      t.timestamps
    end
  end
end
