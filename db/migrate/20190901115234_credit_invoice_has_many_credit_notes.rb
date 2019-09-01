# frozen_string_literal: true

class CreditInvoiceHasManyCreditNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :credit_notes, :credit_invoice_id, :integer, index: true
  end
end
