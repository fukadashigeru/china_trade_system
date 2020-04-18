class CreateActualItemUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :actual_item_units do |t|
      t.references :item_unit, foreign_key: true
      t.references :order, foreign_key: true
      t.references :first_candidate, foreign_key: {to_table: :taobao_urls}
      t.string :item_unit_name
      t.integer :price
      t.string :color_size

      t.timestamps
    end
  end
end
