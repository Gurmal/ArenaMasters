class AddRoundstoFight < ActiveRecord::Migration[5.0]
  def change
  	add_column :fights, :rounds, :integer
  	remove_column :fight_items, :rounds, :integer
  end
end
