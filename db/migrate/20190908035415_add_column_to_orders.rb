class AddColumnToOrders < ActiveRecord::Migration[5.2]
  def up
    add_column :orders, :item_name, :string
    add_column :orders, :retailer_remark, :string
    add_column :orders, :processing_status, :integer
    add_column :orders, :taobao_color_size, :string
  end
  def down
    remove_column :orders, :item_name, :string
    remove_column :orders, :retailer_remark, :string
    remove_column :orders, :processing_status, :integer
    remove_column :orders, :taobao_color_size, :string
  end
end
