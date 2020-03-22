class RemoveItemNoFromItemSet < ActiveRecord::Migration[5.2]
  def up
    remove_column :item_sets, :item_no
  end

  def down
    add_column :item_sets, :item_no, :integer
  end
end
