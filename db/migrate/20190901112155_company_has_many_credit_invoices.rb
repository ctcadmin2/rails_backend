# frozen_string_literal: true

class CompanyHasManyCreditInvoices < ActiveRecord::Migration[5.2]
  def change
    add_column :credit_invoices, :company_id, :integer, index: true
  end
end
