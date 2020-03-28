class RenameColumnToItemUnit < ActiveRecord::Migration[5.2]
  def change
    rename_column :item_units, :item_taobao_name, :item_unit_name
  end
end
