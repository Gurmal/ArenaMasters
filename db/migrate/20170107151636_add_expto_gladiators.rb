class AddExptoGladiators < ActiveRecord::Migration[5.0]
  def change
  	 add_column :gladiators, :exp, :integer
  end
end
