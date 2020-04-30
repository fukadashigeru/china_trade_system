class ColorSizePriceImage < ApplicationRecord
  belongs_to :item_set
  has_many :pictures
  mount_uploader :image, ImageUploader
end
