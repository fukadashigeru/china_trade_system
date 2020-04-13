class SearchCompaniesController < ApplicationController
  def index
    @companies = Company.all.reject{|x| x == current_company}
    @trade_companies = current_company.get_trade_companies
  end
end

