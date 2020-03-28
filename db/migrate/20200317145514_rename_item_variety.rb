class RenameItemVariety < ActiveRecord::Migration[5.2]
  def change
    rename_table :item_varieties, :item_units
  end
end
