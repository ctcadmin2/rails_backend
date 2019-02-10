class CreatePrefs < ActiveRecord::Migration[5.2]
  def change
    create_table :prefs do |t|
      t.jsonb :main, null: false, default: {}
      t.jsonb :company, null: false, default: {}
      t.timestamps
    end
  end
end
