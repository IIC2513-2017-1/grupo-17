class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string  :username,  null: false
      t.string  :email,     null: false
      t.string  :password,  null: false
      t.boolean :is_admin,  null: false, default: false
      t.integer :money,     null: false, default: 0
      t.timestamps
    end
  end
end
