class AddActiveToFightStyle < ActiveRecord::Migration[5.0]
  def change
    add_column :fight_styles, :active, :boolean
  end
end
