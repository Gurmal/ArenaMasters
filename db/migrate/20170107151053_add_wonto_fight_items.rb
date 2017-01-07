class AddWontoFightItems < ActiveRecord::Migration[5.0]
  def change
  	  	  	add_column :fight_items, :won, :boolean
  end
end
