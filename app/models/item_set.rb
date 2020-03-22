class ItemSet < ApplicationRecord
  belongs_to :user
  has_many :orders
  has_many :item_units

  enum item_no_category: { unspecified: 0, buyma: 1, amazon: 2 }

  def build_item_units_and_taobao_urls
    if item_units.empty?
      item_unit = item_units.build
      [[item_unit, 3.times.map{ item_unit.taobao_urls.build }]].to_h
    else
      #TODO: 間違ってるかも
      item_units.map do |item_unit|
        taobao_urls_array = item_unit.taobao_urls.map do |taobao_url|
          taobao_url
        end
        n = 3 - item_unit.taobao_urls.length
        n.times{ taobao_urls_array << item_unit.taobao_urls.build }
        [item_unit, taobao_urls_array]
      end.to_h
    end
  end
end
