class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum account_type: {
  china_buyer: 0, orderer: 1
  }
  has_many :user_orders
  has_many :orders, through: :user_orders
end
