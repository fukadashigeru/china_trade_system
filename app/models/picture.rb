class Picture < ApplicationRecord
  # belongs_to :actual_item_variety
  belongs_to :order
  belongs_to :color_size_price_image

  # validates :url, presence: true
end
