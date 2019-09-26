class CreateTaobaoUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :taobao_urls do |t|
      t.references :item_variety, foreign_key: true
      t.string :url

      t.timestamps
    end
  end
end
