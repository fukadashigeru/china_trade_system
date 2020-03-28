class CreateItemUnitTaobaoUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :item_unit_taobao_urls do |t|
      t.references :item_unit, foreign_key: true
      t.references :taobao_url, foreign_key: true

      t.timestamps
    end
  end
end
