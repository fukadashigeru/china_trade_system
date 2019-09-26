class AddUserIdColumnToOrders < ActiveRecord::Migration[5.2]
  def up
    add_column :orders, :retailer_id, :integer
    add_column :orders, :china_buyer_id, :integer
  end
  def down
    remove_column :orders, :retailer_id, :integer
    remove_column :orders, :china_buyer_id, :integer
  end
end
