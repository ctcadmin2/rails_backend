# frozen_string_literal: true

class CreditInvoiceToJsonb < ActiveRecord::Migration[5.2]
  def change
    change_column :credit_invoices, :contact_info, :jsonb
    change_column :credit_invoices, :cnotes_id, :jsonb
  end
end
