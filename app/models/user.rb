class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
        #  :authentication_keys => [:login], invite_for: 24.hours
  # devise :database_authenticatable, :registerable, :recoverable,
  #        :trackable, :validatable, :confirmable, :lockable,
  #        :timeoutable, :invitable, invite_for: 1.week
  has_many :company_users
  has_many :companies, through: :company_users
  has_many :invited_company_users
  has_many :invited_companies, through: :invited_company_users, class_name: 'Company'

  scope :confirmed, -> do
    where.not(confirmed_at: nil)
  end
end
