class AddIshaveStockColumnToTaobaoUrl < ActiveRecord::Migration[5.2]
  def change
    add_column :taobao_urls, :is_have_stock, :integer, default: 0, null: false
  end
end
