class RemoveForeignKeyItemUnitFromTaobaoUrl < ActiveRecord::Migration[5.2]
  def up
    add_reference :taobao_urls, :user, foreign_key: true
    remove_foreign_key :taobao_urls, :item_units
    remove_index :taobao_urls, :item_variety_id
    remove_column :taobao_urls, :item_variety_id
  end

  def down
    remove_reference :taobao_urls, :user
    add_reference :taobao_urls, :item_variety, foreign_key: { to_table: :item_units }
  end
end
