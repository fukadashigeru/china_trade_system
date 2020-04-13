class SearchCompaniesController < ApplicationController
  def index
    @chinese_buyer_companies = Company.where(is_chinese_buyer_account: 1)
  end
end

