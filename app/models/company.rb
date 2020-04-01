class Company < ApplicationRecord
  has_many :company_users
  has_many :users, through: :company_users
  has_many :item_sets
  has_many :taobao_urls
  enum role: { owner: 0, manager: 1, staff: 2 }
  has_many :japanese_retailer_orders, class_name: 'Order', :foreign_key => 'japanese_retailer_id'
  has_many :chinese_buyer_orders, class_name: 'Order', :foreign_key => 'chinese_buyer_id'
  accepts_nested_attributes_for :japanese_retailer_orders
  accepts_nested_attributes_for :users
  accepts_nested_attributes_for :company_users
  
  def owner
    owner_company_users = company_users.select{|x| x.role == "owner"}
    owner_company_users.map(&:user)
  end
  def members
    members_company_users = company_users.select{|x| x.role != "owner"}
    members_company_users.map(&:user)
  end
end
