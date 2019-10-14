class RemoveRetailerIdAndChinaBuyerIdFromOrders < ActiveRecord::Migration[5.2]
  def up
    remove_column :orders, :retailer_id
    remove_column :orders, :china_buyer_id
  end
  def down
    add_column :orders, :retailer_id, :integer
    add_column :orders, :china_buyer_id, :integer
  end
end
