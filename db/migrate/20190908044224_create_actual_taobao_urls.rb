class CreateActualTaobaoUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :actual_taobao_urls do |t|
      t.references :actual_item_variety, foreign_key: true
      t.string :url

      t.timestamps
    end
  end
end
