class RenameRetailerRemarkToOrders < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :retailer_remark, :japanese_retailer_remark
    rename_column :orders, :processing_status, :japanese_retailer_status
  end
end
