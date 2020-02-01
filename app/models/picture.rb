class Picture < ApplicationRecord
  # belongs_to :actual_item_variety
  belongs_to :order

  # validates :url, presence: true
end
