require 'kconv'
require 'csv'

class Order < ApplicationRecord
  has_many :user_orders
  has_many :users, through: :user_orders
  def self.import(file)
    # binding.pry
    #<Encoding:ASCII-8BIT>
    #<Encoding:ASCII-8BIT>
    # csvファイルを受け取って文字列にする
    csv_text = file.read
    # 文字列をUTF-8に変換
    csv_utf8 = Kconv.toutf8(csv_text)
    # binding.pry
    # csv_utf8 = CSV.parse(Kconv.toutf8(csv_text)) # 二重配列を返す
    # CSV.foreach(file.path, headers: true) do |row|
    CSV.foreach(file.path, encoding: "Shift_JIS:UTF-8",liberal_parsing: true, headers: true) do |row|
      obj = new
      
      temp = {
        quantity: row["受注数"],
        price: row["価格"],
        trade_no: row["取引ID"],
        customer_name: row["名前（本名）"],
        postal: row["郵便番号"],
        address: row["住所"],
        phone: row["電話番号"],
        variation: row["色・サイズ"],
        remark: row["連絡事項"]
      }
      
      obj.attributes = temp.slice(*updatable_attributes)
      # obj.attributes = row.to_hash.slice(*updatable_attributes)
      # binding.pry
      obj.save!
    end
  end

  def self.updatable_attributes
    # ["quantity","price","trade_no","customer_name","postal","address","phone","variation","remark"]
    [:quantity,:price,:trade_no,:customer_name,:postal,:address,:phone,:variation,:remark]
  end
end
