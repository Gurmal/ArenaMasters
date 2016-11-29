class AddLogToFights < ActiveRecord::Migration[5.0]
  def change
    add_column :fights, :log, :string
  end
end
