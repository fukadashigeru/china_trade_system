class CompanyCompany < ApplicationRecord
  belongs_to :japanese_retailer_company, class_name: 'Company'
  belongs_to :chinese_buyer_company, class_name: 'Company'
  enum contact_status: {trade: 0, contact_offer: 1, only_message: 2}

  def find_target_company(current_company)
    if contact_from_company != current_company
      contact_to_company
    elsif contact_to_company != current_company
      contact_from_company
    end
  end
end
