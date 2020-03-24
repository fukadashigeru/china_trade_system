class TaobaoUrl < ApplicationRecord
  belongs_to :user
  has_many :item_unit_taobao_urls
  has_many :item_units, through: :item_unit_taobao_urls

  enum is_have_stock: { have_stock: 0, not_have_stock: 1 }
end
