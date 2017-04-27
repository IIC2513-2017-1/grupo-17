class CreateGees < ActiveRecord::Migration[5.0]
  def change
    create_table :gees do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :description
      t.references :category, foreign_key: true
      t.datetime :expiration_date

      t.timestamps
    end
  end
end
