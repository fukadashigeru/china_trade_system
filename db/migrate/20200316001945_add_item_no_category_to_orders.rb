class AddItemNoCategoryToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :item_no_category, :integer
  end
end
