class ChangeDefaultToIsHaveStockOfTaobaoUrl < ActiveRecord::Migration[5.2]
  def up
    change_column :taobao_urls, :is_have_stock, :integer, default: 1
  end

  def down
    change_column :taobao_urls, :is_have_stock, :integer, default: 0
  end
end
