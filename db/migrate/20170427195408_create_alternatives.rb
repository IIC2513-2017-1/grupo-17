class CreateAlternatives < ActiveRecord::Migration[5.0]
  def change
    create_table :alternatives do |t|
      t.references :field,  null: false, foreign_key: true
      t.string     :value,  null: false
    end
  end
end
