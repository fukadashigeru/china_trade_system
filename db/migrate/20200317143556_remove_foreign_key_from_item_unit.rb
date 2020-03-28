class RemoveForeignKeyFromItemUnit < ActiveRecord::Migration[5.2]
  def up
    remove_reference  :item_varieties,  :item_no
  end

  def down
    remove_reference  :item_varieties,  :item_no
  end
end
