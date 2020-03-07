class RemoveTaobaoColorSizeFromOrders < ActiveRecord::Migration[5.2]
  def up
    remove_column :orders, :taobao_color_size
  end
  def down
    add_column :orders, :taobao_color_size, :string
  end
end
