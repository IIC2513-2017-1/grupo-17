class CreateJoinTableGeesMembers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :gees, :users do |t|
      t.references :gee, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
    end
  end
end
