class AddRoundstoFightItems < ActiveRecord::Migration[5.0]
  def change
  	add_column :fight_items, :rounds, :integer
  	add_column :fight_items, :died, :boolean
  	add_column :fight_items, :wounded, :boolean
  end
end
