class AddUserIdToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :japanese_retailer, foreign_key: {to_table: :users}
    add_reference :orders, :chinese_buyer, foreign_key: {to_table: :users}
  end
end
