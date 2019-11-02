require 'kconv'
require 'csv'
require 'nkf'

class Order < ApplicationRecord
  has_many :user_orders
  has_many :users, through: :user_orders
  belongs_to :japanese_retailer, class_name: 'User'
  belongs_to :chinese_buyer, class_name: 'User'

  def self.import(file, japanese_retailer, chinese_buyer)
    csv_text = file.read
    encoding_type = NKF.guess(csv_text).to_s
    csv_utf8 = Kconv.toutf8(csv_text)
    CSV.parse(csv_utf8, headers: true, liberal_parsing: true) do |row|
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
        japanese_retailer_id: japanese_retailer.id,
        chinese_buyer_id: chinese_buyer.id
      )
    end
  end
end
