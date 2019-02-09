class ChangeTipeToCategory < ActiveRecord::Migration[5.2]
  def change
    rename_column :vehicles, :tipe, :category
  end
end
