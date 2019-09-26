class CreateItemVarieties < ActiveRecord::Migration[5.2]
  def change
    create_table :item_varieties do |t|
      t.references :item_no, foreign_key: true
      t.string :item_taobao_name

      t.timestamps
    end
  end
end
