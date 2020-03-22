class RenameItemNoToItemSet < ActiveRecord::Migration[5.2]
  def change
    rename_table :item_nos, :item_sets
  end
end
