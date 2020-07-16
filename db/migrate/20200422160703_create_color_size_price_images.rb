class CreateColorSizePriceImages < ActiveRecord::Migration[5.2]
  def change
    create_table :color_size_price_images do |t|
      t.references :item_set, foreign_key: true
      t.string :image
      t.string :color_size
      t.integer :price

      t.timestamps
    end
  end
end
