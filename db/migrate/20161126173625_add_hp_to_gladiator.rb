class AddHpToGladiator < ActiveRecord::Migration[5.0]
  def change
    add_column :gladiators, :hp, :integer
    add_column :gladiators, :hitmod, :integer
    add_column :gladiators, :strmod, :integer
    add_column :gladiators, :initiative, :integer
  end
end
