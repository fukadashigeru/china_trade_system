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

  def processing_item_units_and_taobao_urls(taobao_url_params, first_candidate_params, have_stock_params, current_user)
    taobao_url_params.keys.each do |i|
      taobao_url_params[i].keys.each do |j|
        if j == "0"
          item_unit = item_units.create
        else
          item_unit = item_units.find(j.to_i)
        end
        taobao_url_params[i][j].keys.each do |k|
          taobao_url_params[i][j][k].keys.each do |l|
            taobao_url_url = taobao_url_params[i][j][k][l]
            ## TODO 空欄でも削除とかせな
            next unless taobao_url_params[i][j][k][l].present?
            if l == "0"
              taobao_url = current_user.taobao_urls.find_or_create_by(url: taobao_url_url)
              item_unit.item_unit_taobao_urls.create(taobao_url_id: taobao_url.id)
            else
              taobao_url = item_unit.taobao_urls.find(l.to_i)
              item_unit_taobao_url = ItemUnitTaobaoUrl.find_by(item_unit_id: j.to_i , taobao_url_id: l.to_i)
              if taobao_url.item_units.length > 1
                taobao_url = current_user.taobao_urls.find_or_create_by(url: taobao_url_url)
                item_unit_taobao_url.update(taobao_url_id: taobao_url.id)
              else
                taobao_url.update(url: taobao_url_url)
              end
            end
            if k == first_candidate_params
              item_unit.update(first_candidate_id: taobao_url.id)
            end
            taobao_url.update(is_have_stock: have_stock_params[k].to_i)
          end
        end
      end
    end
  end
end
