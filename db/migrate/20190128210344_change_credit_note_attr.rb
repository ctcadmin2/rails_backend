class ChangeCreditNoteAttr < ActiveRecord::Migration[5.2]
  def change
    rename_column :credit_notes, :stop, :end
    remove_column :credit_notes, :week
  end
end
