class ItemSet < ApplicationRecord
  belongs_to :company
  has_many :orders
  has_many :item_units

  enum item_no_category: { unspecified: 0, buyma: 1, amazon: 2 }

  def build_item_units_and_taobao_urls
    if item_units.empty?
      item_unit = item_units.build
      [[item_unit, 3.times.map{ item_unit.taobao_urls.build }]].to_h
    else
      #TODO: 間違ってるかも
      item_units.order(:id).map do |item_unit|
        # taobao_urls_array = item_unit.taobao_urls.map do |taobao_url|
        taobao_urls_array = item_unit.item_unit_taobao_urls.order(:id).map(&:taobao_url).map do |taobao_url|
          taobao_url
        end
        n = 3 - item_unit.taobao_urls.length
        n.times{ taobao_urls_array << item_unit.taobao_urls.build }
        [item_unit, taobao_urls_array]
      end.to_h
    end
  end

  def processing_item_units_and_taobao_urls(taobao_url_params, first_candidate_params, have_stock_params, current_user)
    item_unit_ids_included_in_params = Array.new
    taobao_url_params.keys.each do |i|
      taobao_url_params[i].keys.each do |j|
        if j == "0"
          item_unit = item_units.create
        else
          item_unit = item_units.find(j.to_i)
        end
        item_unit_ids_included_in_params << item_unit.id
        taobao_url_ids_included_in_params = Array.new
        taobao_url_params[i][j].keys.each do |k|
          taobao_url_params[i][j][k].keys.each do |l|
            taobao_url_url = taobao_url_params[i][j][k][l]
            ## TODO 空欄でも削除とかせな
            if l == "0"
              next unless taobao_url_url.present?
              taobao_url = current_user.taobao_urls.find_or_create_by(url: taobao_url_url)
              item_unit.item_unit_taobao_urls.create(taobao_url_id: taobao_url.id)
              taobao_url_ids_included_in_params << taobao_url.id
            else
              taobao_url = item_unit.taobao_urls.find(l.to_i)
              item_unit_taobao_url = ItemUnitTaobaoUrl.find_by(item_unit_id: j.to_i , taobao_url_id: l.to_i)
              if taobao_url.item_units.length > 1
                if taobao_url_url.present?
                  taobao_url = current_user.taobao_urls.find_or_create_by(url: taobao_url_url)
                  item_unit_taobao_url.update(taobao_url_id: taobao_url.id)
                  taobao_url_ids_included_in_params << taobao_url.id
                else
                  item_unit_taobao_url.destroy
                end
              else
                if taobao_url_url.present?
                  other_taobao_url = current_user.taobao_urls.find_by(url: taobao_url_url)
                  if other_taobao_url
                    if other_taobao_url&.id != l.to_i
                      taobao_url.destroy if taobao_url.item_units.length > 1
                      taobao_url = other_taobao_url
                    else
                      taobao_url.update(url: taobao_url_url)
                    end
                  else
                    taobao_url.update(url: taobao_url_url)
                  end
                  taobao_url_ids_included_in_params << taobao_url.id
                else
                  taobao_url.destroy
                end
              end
            end
            ## 第一候補をitem_unitのfirst_candidate_idに登録する
            if first_candidate_params
              if k == first_candidate_params[i]&.keys&.first
                item_unit.update(first_candidate_id: taobao_url.id)
              end
            end
            # 在庫の有無を変更
            if taobao_url_url.present?
              taobao_url.update(is_have_stock: have_stock_params[i][k].to_i)
            end
          end
        end
        ##　item_unit単位でどれにもチェックが入ってないときに、first_candidate_idをnilにする
        ### 他のやつのもふくめてないとき
        if first_candidate_params.nil?
          item_unit.update(first_candidate_id: nil)
        ### 該当するのだけないとき
        elsif !first_candidate_params[i]
          item_unit.update(first_candidate_id: nil)
        end
        #削除処理
        removed_taobao_url_ids = item_unit.taobao_urls.ids - taobao_url_ids_included_in_params
        removed_taobao_url_ids.each do |i|
          removed_taobao_url = current_user.taobao_urls.find(i)
          if removed_taobao_url.item_units.length > 1
            item_unit_taobao_url = ItemUnitTaobaoUrl.find_by(item_unit_id: item_unit.id, taobao_url_id: i)
            item_unit_taobao_url.destroy
          else
            removed_taobao_url.destroy
          end
        end
        if item_unit.taobao_urls.empty?
          item_unit.destroy
        end
      end
    end
    removed_item_unit_ids = item_units.ids - item_unit_ids_included_in_params
    removed_item_unit_ids.each do |i|
      removed_item_unit = item_units.find(i)
      removed_item_unit.destroy
    end
  end
end
