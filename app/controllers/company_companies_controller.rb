class CompanyCompaniesController < ApplicationController
  def index
    @japanese_retailer_company_companies = current_company.japanese_retailer_company_companies.where(contact_status: "trade").includes(:chinese_buyer_company)
    @chinese_buyer_company_companies = current_company.chinese_buyer_company_companies.where(contact_status: "trade").includes(:japanese_retailer_company)
    @japanese_retailer_company_companies_contact_offering = current_company.japanese_retailer_company_companies.where(contact_status: "contact_offer").includes(:chinese_buyer_company)
    @chinese_buyer_company_companies_contact_offered = current_company.chinese_buyer_company_companies.where(contact_status: "contact_offer").includes(:japanese_retailer_company)
  end

  def update
    if company_company = current_company.chinese_buyer_company_companies.find_by(id:params[:id])
      company_company
    else
      company_company = current_company.japanese_retailer_company_companies.find(params[:id])
    end
    topic = company_company.topics.find_by(id:params[:topic_id])
    company_company.update(company_company_params)
    if topic.nil?
      flash[:success] = "取引開始申請を承認しました。"
      redirect_to company_companies_path
    elsif params[:contact_status] == 'trade'
      flash[:success] = "取引開始申請を承認しました。"
      redirect_to chinese_buyer_topic_path(topic)
    elsif params[:contact_status] == 'contact_offer'
      flash[:success] = "取引開始申請しました。"
      redirect_to japanese_retailer_topic_path(topic)
    end
  end

  def company_company_params
    params.permit(:contact_status)
  end
end
