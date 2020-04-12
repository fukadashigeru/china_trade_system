class CompanyCompaniesController < ApplicationController
  def index
    @trade_companies_array = current_company.trade_companies_array
    @contact_from_self_companies = current_company.contact_from_self_company_companies.where(contact_status: 1).map(&:contact_to_company)
    @contact_to_self_companies = current_company.contact_to_self_company_companies.where(contact_status: 1).map(&:contact_from_company)
  end
end
