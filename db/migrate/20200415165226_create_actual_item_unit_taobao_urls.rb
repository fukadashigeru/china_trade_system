class CreateActualItemUnitTaobaoUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :actual_item_unit_taobao_urls do |t|
      t.references :actual_item_unit, foreign_key: true
      t.references :taobao_url, foreign_key: true

      t.timestamps
    end
  end
end
