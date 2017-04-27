class CreateValues < ActiveRecord::Migration[5.0]
  def change
    create_table :values do |t|
      t.references :bet, foreign_key: true
      t.references :field, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
