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

  def processing_item_units_and_taobao_urls(taobao_url_params, first_candidate_params, have_stock_params, current_company, remove_taobao_url_params, remove_item_unit_params)
    # item_unit_ids_included_in_params = Array.new
    taobao_url_params.keys.each do |i|
      taobao_url_params[i].keys.each do |j|
        if j == "0"
          item_unit = item_units.create
        else
          item_unit = item_units.find(j.to_i)
        end
        # binding.pry
        # item_unit_ids_included_in_params << item_unit.id
        # taobao_url_ids_included_in_params = Array.new
        taobao_url_params[i][j].keys.each do |k|
          taobao_url_params[i][j][k].keys.each do |l|
            taobao_url_params_url = taobao_url_params[i][j][k][l]
            # 新規入力のinput_fieldの場合(元々空の場合)
            if l == "0"
              next unless taobao_url_params_url.present?
              new_taobao_url = current_company.taobao_urls.find_or_create_by(url: taobao_url_params_url)
              item_unit.item_unit_taobao_urls.create(taobao_url_id: new_taobao_url.id)
              # taobao_url_ids_included_in_params << taobao_url.id
            # 上書きされたinput_fieldの場合
            else
              old_taobao_url = item_unit.taobao_urls.find(l.to_i)
              # item_unit_taobao_url = ItemUnitTaobaoUrl.find_by(item_unit_id: j.to_i , taobao_url_id: l.to_i)
              item_unit_taobao_url = current_company.taobao_urls.find(l.to_i).item_unit_taobao_urls.find_by(item_unit_id: j.to_i)
              # 当該のitem_unit以外に当該のtaobao_urlにitem_unitかactual_item_unitがつながってる場合
              if old_taobao_url.item_units.length + old_taobao_url.actual_item_units.length > 1
                if taobao_url_params_url.present?
                  new_taobao_url = current_company.taobao_urls.find_or_create_by(url: taobao_url_params_url)
                  item_unit_taobao_url.update(taobao_url_id: new_taobao_url.id)
                  # taobao_url_ids_included_in_params << taobao_url.id
                else
                  item_unit_taobao_url.destroy
                end
              # 当該のitem_unitだけが当該のtaobao_urlにつながってる場合
              else
                if taobao_url_params_url.present?
                  new_taobao_url = current_company.taobao_urls.find_by(url: taobao_url_params_url)
                  # 入力されたURLのレコードが既にある場合
                  if new_taobao_url
                    if new_taobao_url&.id != l.to_i
                      old_taobao_url.destroy
                      new_taobao_url.item_unit_taobao_urls.find_or_create_by(item_unit_id: item_unit.id )
                    else
                      # ここの記述いらんかも
                      # taobao_url.update(url: taobao_url_params_url)
                    end
                  else
                    old_taobao_url.update(url: taobao_url_params_url)
                  end
                  # taobao_url_ids_included_in_params << taobao_url.id
                # 入力されたURLのレコードが既にない場合
                else
                  old_taobao_url.destroy
                end
              end
            end
            ## 第一候補をitem_unitのfirst_candidate_idに登録する
            if first_candidate_params
              if k == first_candidate_params[i]&.keys&.first
                item_unit.update(first_candidate_id: new_taobao_url.id)
              end
            end
            # 在庫の有無を変更
            if taobao_url_params_url.present?
              new_taobao_url.update(is_have_stock: have_stock_params[i][k].to_i)
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
        # binding.pry
        if remove_taobao_url_params
          if remove_taobao_url_params[i]
            if remove_taobao_url_params[i][j]
              remove_taobao_url_params[i][j].keys.each do |m|
                remove_taobao_url_params[i][j][m].keys.each do |n|
                  # binding.pry
                  remove_taobao_url = item_unit.taobao_urls.find(n.to_i)
                  if remove_taobao_url.item_units.length + remove_taobao_url.actual_item_units.length > 1
                    remove_taobao_url.item_unit_taobao_urls.find_by(item_unit_id: item_unit.id).destroy
                  else
                    remove_taobao_url.destroy
                  end
                end
              end
            end
          end
        end
        if item_unit.taobao_urls.empty?
          item_unit.destroy
        end
      end
    end
    if remove_item_unit_params
      remove_item_unit_params.keys.each do |o|
        remove_item_unit_params[o].keys.each do |p|
          item_unit = item_units.find(p.to_i)
          item_unit.destroy
        end
      end
    end
  end
end
