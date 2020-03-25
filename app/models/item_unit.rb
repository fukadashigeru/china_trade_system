class ItemUnit < ApplicationRecord
  belongs_to :item_set
  belongs_to :first_candidate, class_name: 'TaobaoUrl', foreign_key: :first_candidate_id, optional: true
  has_many :item_unit_taobao_urls, inverse_of: :item_unit
  has_many :taobao_urls, through: :item_unit_taobao_urls
end
