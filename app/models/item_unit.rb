class ItemUnit < ApplicationRecord
  belongs_to :item_set
  has_many :item_unit_taobao_urls
  has_many :taobao_urls, through: :item_unit_taobao_urls
end
