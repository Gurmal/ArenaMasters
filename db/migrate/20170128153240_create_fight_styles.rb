class CreateFightStyles < ActiveRecord::Migration[5.0]
  def change
    create_table :fight_styles do |t|
      t.string :name

      t.timestamps
    end
  end
end
