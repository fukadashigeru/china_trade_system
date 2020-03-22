class TaobaoUrl < ApplicationRecord
  belongs_to :user
  has_many :item_unit_taobao_urls
  has_many :item_units, through: :item_unit_taobao_urls
end
