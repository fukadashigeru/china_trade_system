require 'kconv'
require 'csv'
require 'nkf'

class Order < ApplicationRecord
  has_many :pictures
  has_one :taobao_color_size
  # accepts_nested_attributes_for :taobao_color_size, update_only: true
  accepts_nested_attributes_for :taobao_color_size
  accepts_nested_attributes_for :pictures
  belongs_to :japanese_retailer, class_name: 'User'
  belongs_to :chinese_buyer, class_name: 'User'
  belongs_to :item_set, optional: true

  def self.import(file, japanese_retailer, chinese_buyer)
    csv_text = file.read
    encoding_type = NKF.guess(csv_text).to_s
    csv_utf8 = Kconv.toutf8(csv_text)
    CSV.parse(csv_utf8, headers: true, liberal_parsing: true) do |row|
      next if row["商品ID"].nil?
      item_set = ItemSet.find_or_initialize_by(
        user_id: japanese_retailer.id,
        item_no_category: 1,
        item_no: row["商品ID"]
      )
      item_set.assign_attributes(
        item_set_name: row["商品名"],
        shop_url: "https://www.buyma.com/item/" + row["商品ID"] + "/"
      )
      item_set.save!
      obj = find_or_initialize_by(trade_no: row["取引ID"])
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
        japanese_retailer_id: japanese_retailer.id,
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

end
