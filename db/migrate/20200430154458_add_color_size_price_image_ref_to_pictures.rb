class AddColorSizePriceImageRefToPictures < ActiveRecord::Migration[5.2]
  def change
    add_reference :pictures, :color_size_price_image, foreign_key: true
  end
end
