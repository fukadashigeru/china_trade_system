class ItemUnitTaobaoUrl < ApplicationRecord
  belongs_to :item_unit
  belongs_to :taobao_url
  # validates :item_unit_id, :uniqueness => {:scope => :taobao_url_id}
end
