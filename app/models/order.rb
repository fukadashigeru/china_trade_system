require 'kconv'
require 'csv'
require 'nkf'

class Order < ApplicationRecord
  has_many :user_orders
  has_many :users, through: :user_orders

  def self.import(file, china_buyer_id, current_user)
    csv_text = file.read
    encoding_type = NKF.guess(csv_text).to_s
    csv_utf8 = Kconv.toutf8(csv_text)
    CSV.parse(csv_utf8, headers: true, liberal_parsing: true) do |row|
      obj = find_by(trade_no: row["取引ID"]) || new
      obj.assign_attributes(
        quantity: row["受注数"],
        price: row["価格"],
        trade_no: row["取引ID"],
        customer_name: row["名前（本名）"],
        postal: row["郵便番号"],
        address: row["住所"],
        phone: row["電話番号"],
        color_size: row["色・サイズ"],
        customer_remark: row["連絡事項"]
      )
      # 発注者（日本人）と買付担当（中国人）のidを保存
      obj.update(retailer_id: current_user.id, china_buyer_id: china_buyer_id)
      obj.save!
      # 発注者（日本人）とのリレーションを保存
      obj.users << current_user unless obj.users.include?(current_user)
      # 買付担当（中国人）とのリレーションを保存
      china_buyer = User.find(china_buyer_id)
      obj.users << china_buyer unless obj.users.include?(china_buyer)
    end
  end

  # def self.updatable_attributes
  #   [:quantity,:price,:trade_no,:customer_name,:postal,:address,:phone,:color_size,:customer_remark]
  # end
end
