class ChangeCompanyVies < ActiveRecord::Migration[5.1]
  def change
    rename_column :companies, :vies_valid, :vies
  end
end
