class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum account_type: {
  china_buyer: 0, orderer: 1
  }
  has_many :item_sets
  has_many :taobao_urls
  has_many :company_users
  has_many :companies, through: :company_users
end
