class InvitedCompanyUser < ApplicationRecord
  belongs_to :company
  belongs_to :user

  def validation_save
    invited_company_user = InvitedCompanyUser.find_by(user_id: user_id, company_id: company_id)
    company_user = CompanyUser.find_by(user_id: user_id, company_id: company_id)
    if invited_company_user.nil? && company_user.nil?
      save
    else
      raise "Invalid Error"
    end
  end
end
