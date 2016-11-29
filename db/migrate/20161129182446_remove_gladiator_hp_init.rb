class RemoveGladiatorHpInit < ActiveRecord::Migration[5.0]
  def change
  remove_column :gladiators, :hp
  remove_column :gladiators, :initiative
  end
end
