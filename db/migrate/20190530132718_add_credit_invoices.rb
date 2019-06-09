# frozen_string_literal: true

class AddCreditInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_invoices do |t|
      t.string   'number'
      t.date     'date'
      t.string   'tax_rate'
      t.decimal  'net_value',   precision: 8, scale: 2
      t.decimal  'tax_value',   precision: 8, scale: 2
      t.decimal  'total_value', precision: 8, scale: 2
      t.string   'currency'
      t.json     'contact_info', null: false, default: {}
      t.json     'cnotes_id', null: false, default: {}
      t.timestamps
    end
  end
end
