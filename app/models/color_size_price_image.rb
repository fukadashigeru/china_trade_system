class ColorSizePriceImage < ApplicationRecord
  belongs_to :item_set
  mount_uploader :image, ImageUploader
end
