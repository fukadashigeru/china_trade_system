class AddShopUrlColumnToItemSet < ActiveRecord::Migration[5.2]
  def change
    add_column :item_sets, :shop_url, :string
  end
end
