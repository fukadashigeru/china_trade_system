class AddShopUrlColumnToOrder < ActiveRecord::Migration[5.2]
  def up
    add_column :orders, :shop_url, :string
  end

  def down
    add_column :orders, :shop_url, :string
  end
end
