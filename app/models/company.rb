class Company < ApplicationRecord
  has_many :company_users
  has_many :users, through: :company_users
  has_many :item_sets
  has_many :taobao_urls
  enum is_japanese_retailer_account: { not_japanese_retailer: 0, japanese_retailer: 1 }
  enum is_chinese_buyer_account: { not_chinese_buyer: 0, chinese_buyer: 1 }
  has_many :japanese_retailer_orders, class_name: 'Order', :foreign_key => 'japanese_retailer_id'
  has_many :chinese_buyer_orders, class_name: 'Order', :foreign_key => 'chinese_buyer_id'
  accepts_nested_attributes_for :japanese_retailer_orders
  accepts_nested_attributes_for :users
  accepts_nested_attributes_for :company_users
  has_many :japanese_retailer_company_companies, class_name: 'CompanyCompany', :foreign_key => 'japanese_retailer_company_id'
  has_many :chinese_buyer_company_companies, class_name: 'CompanyCompany', :foreign_key => 'chinese_buyer_company_id'
  has_many :company_connects
  has_many :connects , through: :company_connects
  has_many :connects_from_self, class_name: 'Connect', :foreign_key => 'from_company_id'
  has_many :connects_to_self, class_name: 'Connect', :foreign_key => 'to_company_id'
  
  def owner
    owner_company_users = company_users.select{|x| x.role == "owner"}
    owner_company_users.map(&:user)
  end

  def members
    members_company_users = company_users.select{|x| x.role != "owner"}
    members_company_users.map(&:user)
  end

  def trade_companies_array
    contact_from_self_company_companies.where(contact_status: 0).map(&:contact_to_company) + contact_to_self_company_companies.where(contact_status: 0).map(&:contact_from_company)
  end

  def find_or_create_company_company(target_company_id)
    contact_to_self_company_company = contact_to_self_company_companies.find_by(contact_from_company_id: target_company_id)
    contact_from_self_company_company = contact_from_self_company_companies.find_by(contact_to_company_id: target_company_id)
    if contact_to_self_company_company
      contact_to_self_company_company
    elsif contact_from_self_company_company
      contact_from_self_company_company
    else
      CompanyCompany.create(contact_from_company_id: self.id, contact_to_company_id: target_company_id, contact_status: "only_message")
    end
  end

  def get_trade_companies
    connects.map(&:companies).flatten.reject{|x| x == self}
  end

  def get_trade_company_connects
    connects.map(&:company_connects).flatten.reject{|x| x.company == self}
  end

  def get_connect_of_target_company(target_company)
    connects.each do |connect|
      if connect.companies.include?(target_company)
        target_connect = connect
      end
    end
    target_connect
  end
end
