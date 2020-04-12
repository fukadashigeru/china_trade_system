class CompanyCompany < ApplicationRecord
  belongs_to :contact_from_company, class_name: 'Company'
  belongs_to :contact_to_company, class_name: 'Company'
end
