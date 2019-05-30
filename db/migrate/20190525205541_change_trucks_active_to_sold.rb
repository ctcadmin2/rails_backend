# frozen_string_literal: true

class ChangeTrucksActiveToSold < ActiveRecord::Migration[5.2]
  def change
    rename_column :vehicles, :active, :sold
    change_column :vehicles, :sold, :boolean, default: false
  end
end
