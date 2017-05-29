class AddCorrectValueToField < ActiveRecord::Migration[5.0]
  def change
    add_column :fields, :correct_value, :integer
  end
end
