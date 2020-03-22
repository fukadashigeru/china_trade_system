class AddItemNoCategoryToItemSets < ActiveRecord::Migration[5.2]
  def change
    add_column :item_sets, :item_no_category, :integer, comment: '指定なし,Buyma,Amazon..'
  end
end
