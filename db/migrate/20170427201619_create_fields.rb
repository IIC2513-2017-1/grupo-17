class CreateFields < ActiveRecord::Migration[5.0]
  def change
    create_table :fields do |t|
      t.references :gee, foreign_key: true
      t.string :name
      t.string :type
      t.integer :min_value
      t.integer :max_value

      t.timestamps
    end
  end
end
