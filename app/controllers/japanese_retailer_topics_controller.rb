class JapaneseRetailerTopicsController < ApplicationController
  def index
    @chinese_buyer_company = Company.where(is_chinese_buyer_account: 1).find(params[:company_id])
    @company_company = current_company.japanese_retailer_company_companies.find_or_create_by(chinese_buyer_company: @chinese_buyer_company)
    @topic = @company_company.topics
    if @topic.present?
      render "index"
    else
      @topic = @company_company.topics.create(title: "コンタクト依頼", topic_variety: "contact")
      @message = @topic.messages.build
      render "show"
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @company_company = @topic.company_company
    @message = @topic.messages.build
  end

end
