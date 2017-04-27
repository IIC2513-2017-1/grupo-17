class CreateBets < ActiveRecord::Migration[5.0]
  def change
    create_table :bets do |t|
      t.references :user, foreign_key: true
      t.references :gee, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
