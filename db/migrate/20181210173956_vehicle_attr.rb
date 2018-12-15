class VehicleAttr < ActiveRecord::Migration[5.2]
  def change
    add_column :vehicles, :vin, :string
    add_column :vehicles, :registration, :string
    add_column :vehicles, :type, :string
    add_column :vehicles, :active, :boolean
  end
end
