class CreateColorSizePriceImages < ActiveRecord::Migration[5.2]
  def change
    create_table :color_size_price_images do |t|
      t.string :image
      t.string :color

      t.timestamps
    end
  end
end
