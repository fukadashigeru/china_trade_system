class TaobaoUrl < ApplicationRecord
  belongs_to :user
  has_many :item_unit_taobao_urls, dependent: :destroy #TaobaoUrlが削除されたら、子要素のItemUnitTaobaoUrlも削除する
  has_many :item_units, through: :item_unit_taobao_urls
  has_many :item_units_where_i_am_first_candidate, class_name: 'ItemUnit', foreign_key: :first_candidate_id, dependent: :nullify
  enum is_have_stock: { have_stock: 0, not_have_stock: 1 }
  validates :is_have_stock, presence: true
end
