class CreditNoteAttr < ActiveRecord::Migration[5.2]
  def change
    add_column :credit_notes, :number, :string
    add_column :credit_notes, :start, :string
    add_column :credit_notes, :stop, :string
    add_column :credit_notes, :week, :string
    add_column :credit_notes, :value, :decimal
    add_column :credit_notes, :currency, :string
    add_column :credit_notes, :notes, :text
    add_column :credit_notes, :paid, :boolean
  end
end
