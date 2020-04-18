class ActualItemUnit < ApplicationRecord
  belongs_to :item_unit, optional: true
  belongs_to :order
  belongs_to :first_candidate, class_name: 'TaobaoUrl', foreign_key: :first_candidate_id, optional: true
  has_many :actual_item_unit_taobao_urls
  has_many :taobao_urls, through: :actual_item_unit_taobao_urls
end
