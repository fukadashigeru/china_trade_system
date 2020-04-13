class CompanyConnectsController < ApplicationController
  def index
    @company_connects = current_company.get_trade_company_connects
  end

  def show
  end

  def create
    target_company = Company.find(params[:company_id])
    connect = Connect.create(contact_status: "only_message")
    current_company_connect = current_company.company_connects.create(connect_id: connect.id)
    target_company_connect = target_company.company_connects.create(connect_id: connect.id)
    topic = connect.topics.create(title: "コンタクト依頼", topic_variety: "contact")
    redirect_to topic_path(topic)
  end
end
