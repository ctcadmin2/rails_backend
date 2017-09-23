class CompanyAttributes < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :name, :string
    add_column :companies, :registration, :string
    add_column :companies, :cif, :string
    add_column :companies, :address, :text
    add_column :companies, :acc_eur, :string
    add_column :companies, :acc_ron, :string
    add_column :companies, :bank, :string
    add_column :companies, :capital, :string
    add_column :companies, :phone, :string
    add_column :companies, :email, :string
    add_column :companies, :contact, :string
    add_column :companies, :country, :string
    add_column :companies, :vies_valid, :boolean, default: false
    add_column :companies, :status, :boolean, default: true
  end
end
