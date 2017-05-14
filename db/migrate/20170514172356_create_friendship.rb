class CreateFriendship < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships do |t|
      t.references :user, foreign_key: true
      t.references :friend, foreign_key: { to_table: :users }
      t.boolean :confirmed

      t.timestamps
    end
  end
end
