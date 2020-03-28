class RenameColumnsToItemsSet < ActiveRecord::Migration[5.2]
  def change
    rename_column :item_sets, :item_name, :item_set_name
  end
end
