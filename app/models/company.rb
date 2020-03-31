class Company < ApplicationRecord
  has_many :company_users
  has_many :users, through: :company_users
  enum role: { owner: 0, manager: 1, staff: 2 }

  def members
    members_company_users = company_users.select{|x| x.role != 0}
    members_company_users.map(&:users)
  end
end
