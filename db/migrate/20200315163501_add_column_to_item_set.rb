class AddColumnToItemSet < ActiveRecord::Migration[5.2]
  def up
    add_column :item_sets, :item_no, :integer
  end

  def down
    remove_column :item_sets, :item_no, :integer
  end
end
