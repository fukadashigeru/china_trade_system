class Connect < ApplicationRecord
  has_many :company_connects
  has_many :companies, through: :company_connects
  has_many :topics
  belongs_to :from_company, class_name: 'Company', optional: true
  belongs_to :to_company, class_name: 'Company', optional: true
  enum contact_status: {trade: 0, offer: 1, only_message: 2}
  
  def get_target_company(current_company)
    targete_companies = companies.reject{|x| x == current_company}
    if targete_companies.length == 1
      targete_companies.first
    else
      raise Error
    end
  end
end
