class CreateBets < ActiveRecord::Migration[5.0]
  def change
    create_table :bets do |t|
      t.references  :user,     null: false, foreign_key: true
      t.references  :gee,      null: false, foreign_key: true
      t.integer     :quantity, null: false
      t.timestamps
    end
  end
end
