class CreateGees < ActiveRecord::Migration[5.0]
  def change
    create_table :gees do |t|
      t.references :user,             null: false, foreign_key: true
      t.references :category,         null: false, foreign_key: true
      t.string     :name,             null: false
      t.string     :description,      null: false, default: ""
      t.string     :state,            null: false, default: "opened"
      t.boolean    :is_public,        null: false, default: true
      t.datetime   :expiration_date,  null: false
      t.timestamps
    end
  end
end
