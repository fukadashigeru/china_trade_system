class CompanyUser < ApplicationRecord
  belongs_to :user
  belongs_to :company
  enum role: { owner: 0, manager: 1, staff: 2}
end
