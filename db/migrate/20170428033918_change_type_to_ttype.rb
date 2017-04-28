class ChangeTypeToTtype < ActiveRecord::Migration[5.0]
  def change
    rename_column :fields, :type, :ttype
  end
end
