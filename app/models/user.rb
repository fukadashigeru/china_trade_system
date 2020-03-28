class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum account_type: {
  china_buyer: 0, orderer: 1
  }
  has_many :user_orders
  has_many :japanese_retailer_orders, class_name: 'Order', :foreign_key => 'japanese_retailer_id'
  has_many :chinese_buyer_orders, class_name: 'Order', :foreign_key => 'chinese_buyer_id'
  has_many :item_sets
  accepts_nested_attributes_for :japanese_retailer_orders
  has_many :taobao_urls
end
