class RenameVehicleTypeToTipe < ActiveRecord::Migration[5.2]
  def change
    rename_column :vehicles, :type, :tipe
  end
end
