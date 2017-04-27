class CreateAlternatives < ActiveRecord::Migration[5.0]
  def change
    create_table :alternatives do |t|
      t.references :field, foreign_key: true
      t.string :value

      t.timestamps
    end
  end
end
