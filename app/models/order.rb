require 'kconv'
require 'csv'
require 'nkf'

class Order < ApplicationRecord
  has_many :pictures
  has_one :taobao_color_size
  has_many :topics
  has_many :actual_item_units
  # accepts_nested_attributes_for :taobao_color_size, update_only: true
  accepts_nested_attributes_for :taobao_color_size
  accepts_nested_attributes_for :pictures
  belongs_to :japanese_retailer, class_name: 'Company'
  belongs_to :chinese_buyer, class_name: 'Company'
  belongs_to :item_set, optional: true

  def self.import(file, japanese_retailer, chinese_buyer)
    csv_text = file.read
    encoding_type = NKF.guess(csv_text).to_s
    csv_utf8 = Kconv.toutf8(csv_text)
    CSV.parse(csv_utf8, headers: true, liberal_parsing: true) do |row|
      next if row["商品ID"].nil?
      item_set = japanese_retailer.item_sets.find_or_initialize_by(
        company_id: japanese_retailer.id,
        item_no_category: 1,
        item_no: row["商品ID"]
      )
      item_set.assign_attributes(
        item_set_name: row["商品名"],
        shop_url: "https://www.buyma.com/item/" + row["商品ID"] + "/"
      )
      item_set.save!
      obj = japanese_retailer.japanese_retailer_orders.find_or_initialize_by(trade_no: row["取引ID"])
      obj.assign_attributes(
        quantity: row["受注数"],
        price: row["価格"],
        trade_no: row["取引ID"],
        customer_name: row["名前（本名）"],
        postal: row["郵便番号"],
        address: row["住所"],
        phone: row["電話番号"],
        color_size: row["色・サイズ"],
        customer_remark: row["連絡事項"],
        japanese_retailer_remark: row["受注メモ"],
        chinese_buyer_id: chinese_buyer.id,
        item_set_id: item_set.id
      )
      obj.save!
    end
  end

  # モーダルページで、保存済みのpictureのidがparamsに乗ってこなかったら、削除するメソッド
  def remove_pictures_of_not_included_in_params(order_params)
    # {"0"=><ActionController::Parameters {"id"=>"211", "url"=>"https://static-buyma-com.akamaized.net/imgdata/item/180428/0035698545/145425227/428.jpg"} permitted: true>, "2"=><ActionController::Parameters {"id"=>"224", "url"=>"https://static-buyma-com.akamaized.net/imgdata/item/180428/0035698545/159579735/428.jpg"} permitted: true>}
    already_saved_pictures_array = pictures
    pictures_params = order_params[:pictures_attributes]
    pictures_attributes_ids = if pictures_params.nil?
      Array.new
    else
      pictures_params.values.map do |picture_params|
        picture_params[:id].to_i
      end
    end
    already_saved_pictures_array.each do |picture|
      if !pictures_attributes_ids.include?(picture.id)
        picture.destroy
      end
    end
  end

  def build_actual_item_units_and_taobao_urls
    if actual_item_units.empty?
      actual_item_unit = actual_item_units.build
      [[actual_item_unit, 3.times.map{ actual_item_unit.taobao_urls.build }]].to_h
    else
      #TODO: 間違ってるかも
      actual_item_units.order(:id).map do |actual_item_unit|
        # taobao_urls_array = actual_item_unit.taobao_urls.map do |taobao_url|
        taobao_urls_array = actual_item_unit.actual_item_unit_taobao_urls.order(:id).map(&:taobao_url).map do |taobao_url|
          taobao_url
        end
        n = 3 - actual_item_unit.taobao_urls.length
        n.times{ taobao_urls_array << actual_item_unit.taobao_urls.build }
        [actual_item_unit, taobao_urls_array]
      end.to_h
    end
  end

  # 今回の買付先を更新するメソッド
  def processing_actual_item_units_and_taobao_urls(taobao_url_params, first_candidate_params, have_stock_params, current_company, remove_taobao_url_params, remove_actual_item_unit_params)
    taobao_url_params.keys.each do |i|
      taobao_url_params[i].keys.each do |j|
        if j == "0"
          actual_item_unit = actual_item_units.create
        else
          actual_item_unit = actual_item_units.find(j.to_i)
        end
        taobao_url_params[i][j].keys.each do |k|
          taobao_url_params[i][j][k].keys.each do |l|
            taobao_url_params_url = taobao_url_params[i][j][k][l]
            # 新規入力のinput_fieldの場合(元々空の場合)
            if l == "0"
              next unless taobao_url_params_url.present?
              new_taobao_url = current_company.taobao_urls.find_or_create_by(url: taobao_url_params_url)
              # 既に中間テーブルがない場合
              actual_item_unit.actual_item_unit_taobao_urls.find_or_create_by(taobao_url_id: new_taobao_url.id)
            # 上書きされたinput_fieldの場合
            else
              old_taobao_url = actual_item_unit.taobao_urls.find(l.to_i)
              # actual_item_unit_taobao_url = ActualItemUnitTaobaoUrl.find_by(actual_item_unit_id: j.to_i , taobao_url_id: l.to_i)
              actual_item_unit_taobao_url = current_company.taobao_urls.find(l.to_i).actual_item_unit_taobao_urls.find_by(actual_item_unit_id: j.to_i)
              # 当該のactual_item_unit以外に当該のtaobao_urlにitem_unitかactual_item_unitがつながってる場合
              if old_taobao_url.item_units.length + old_taobao_url.actual_item_units.length > 1
                if taobao_url_params_url.present?
                  new_taobao_url = current_company.taobao_urls.find_or_create_by(url: taobao_url_params_url)
                  actual_item_unit_taobao_url.update(taobao_url_id: new_taobao_url.id)
                  # taobao_url = new_taobao_url
                # 当該のactual_item_unit以外に当該のtaobao_urlにitem_unitかactual_item_unitがつながってる場合に、中間テーブルを削除
                # taobao_urlは他のItemUnit or ActualItemUnitと紐付いているので削除不要
                else
                  actual_item_unit_taobao_url.destroy
                end
              # 当該のactual_item_unitだけが当該のtaobao_urlにつながってる場合
              else
                if taobao_url_params_url.present?
                  new_taobao_url = current_company.taobao_urls.find_by(url: taobao_url_params_url)
                  # 入力されたURLのレコードが既にある場合
                  if new_taobao_url
                    # 入力されたURLの既存のレコードが、当該のtaobao_urlではない場合
                    if new_taobao_url&.id != l.to_i
                      old_taobao_url.destroy 
                      new_taobao_url.actual_item_unit_taobao_urls.find_or_create_by(actual_item_unit_id: actual_item_unit.id )
                    end
                  # 入力されたURLのレコードが既にない場合
                  else
                     old_taobao_url.update(url: taobao_url_params_url)
                  end
                else
                  old_taobao_url.destroy
                end
              end
            end
            ## 第一候補をactual_item_unitのfirst_candidate_idに登録する
            if first_candidate_params
              if k == first_candidate_params[i]
                actual_item_unit.update(first_candidate_id: new_taobao_url.id)
              end
            end
            # 在庫の有無を変更
            if taobao_url_params_url.present?
              new_taobao_url.update(is_have_stock: have_stock_params[i][k].to_i)
            end
          end
        end
        ##　actual_item_unit単位でどれにもチェックが入ってないときに、first_candidate_idをnilにする
        ### 他のやつのもふくめてないとき
        if first_candidate_params.nil?
          actual_item_unit.update(first_candidate_id: nil)
        ### 該当するのだけないとき
        elsif !first_candidate_params[i]
          actual_item_unit.update(first_candidate_id: nil)
        end
        #削除処理
        if remove_taobao_url_params
          if remove_taobao_url_params[i]
            if remove_taobao_url_params[i][j]
              remove_taobao_url_params[i][j].keys.each do |m|
                remove_taobao_url_params[i][j][m].keys.each do |n|
                  remove_taobao_url = actual_item_unit.taobao_urls.find(n.to_i)
                  if remove_taobao_url.item_units.length + remove_taobao_url.actual_item_units.length > 1
                    remove_taobao_url.actual_item_unit_taobao_urls.find_by(actual_item_unit_id: actual_item_unit.id).destroy
                  else
                    remove_taobao_url.destroy
                  end
                end
              end
            end
          end
        end
        if actual_item_unit.taobao_urls.empty?
          actual_item_unit.destroy
        end
      end
    end
    if remove_actual_item_unit_params
      remove_actual_item_unit_params.keys.each do |o|
        remove_actual_item_unit_params[o].keys.each do |p|
          actual_item_unit = actual_item_units.find(p.to_i)
          actual_item_unit.destroy
        end
      end
    end
  end
end
