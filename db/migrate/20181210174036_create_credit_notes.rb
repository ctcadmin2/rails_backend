class CreateCreditNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_notes do |t|

      t.timestamps
    end
  end
end
