class RemoveSomeColumnsFromOrder < ActiveRecord::Migration[5.2]
  def up
    remove_column :orders, :item_no
    remove_column :orders, :item_no_category
    remove_column :orders, :shop_url
  end

  def down
    add_column :orders, :item_no, :integer
    add_column :orders, :item_no_category, :integer
    add_column :orders, :shop_url, :string
  end
end
