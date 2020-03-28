class RemoveItemNameColumnFromOrder < ActiveRecord::Migration[5.2]
  def up
    remove_column :orders, :item_name
  end

  def down
    add_column :orders, :item_name, :string
  end
end
