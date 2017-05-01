class CreateFields < ActiveRecord::Migration[5.0]
  def change
    create_table :fields do |t|
      t.references :gee,        null: false, foreign_key: true
      t.string     :name,       null: false
      t.string     :ttype,      null: false
      t.integer    :min_value
      t.integer    :max_value
    end
  end
end
