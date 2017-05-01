class CreateValues < ActiveRecord::Migration[5.0]
  def change
    create_table :values do |t|
      t.references  :bet,   null: false, foreign_key: true
      t.references  :field, null: false, foreign_key: true
      t.integer     :value, null: false
    end
  end
end
