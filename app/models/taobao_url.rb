class TaobaoUrl < ApplicationRecord
  belongs_to :company
  has_many :item_unit_taobao_urls, dependent: :destroy #TaobaoUrlが削除されたら、子要素のItemUnitTaobaoUrlも削除する
  has_many :item_units, through: :item_unit_taobao_urls
  has_many :item_units_where_i_am_first_candidate, class_name: 'ItemUnit', foreign_key: :first_candidate_id, dependent: :nullify
  has_many :actual_item_unit_taobao_urls, dependent: :destroy 
  has_many :actual_item_units, through: :actual_item_unit_taobao_urls
  has_many :actual_item_units_where_i_am_first_candidate, class_name: 'ActualItemUnit', foreign_key: :first_candidate_id, dependent: :nullify
  enum is_have_stock: { have_stock: 1, not_have_stock: 0 }
  validates :is_have_stock, presence: true
end
