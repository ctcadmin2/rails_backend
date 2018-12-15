class AddVehicleToCreditNotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :credit_notes, :vehicle, foreign_key: true
  end
end
