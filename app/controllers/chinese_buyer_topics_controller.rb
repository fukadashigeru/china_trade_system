class ChineseBuyerTopicsController < ApplicationController
  def index
    @japanese_retailer_company = Company.where(is_japanese_retailer_account: 1).find(params[:company_id])
    @company_company = current_company.chinese_buyer_company_companies.find_by(japanese_retailer_company: @japanese_retailer_company)
    @topic = @company_company.topics
  end

  def show
    @topic = Topic.find(params[:id])
    @company_company = @topic.company_company
    @message = @topic.messages.build
  end
end
