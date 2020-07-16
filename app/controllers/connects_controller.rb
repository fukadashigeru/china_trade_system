class ConnectsController < ApplicationController
  def new
    @target_company = Company.find(params[:company_id])
    @connect = Connect.new(contact_status: "only_message")
    @topic = Topic.new(title: "コンタクト依頼", topic_variety: "contact")
  end

  def create
    target_company = Company.find(params[:company_id])
    connect = Connect.create(connect_params_of_create(current_company.id, target_company.id))
    current_company_connect = current_company.company_connects.create(connect_id: connect.id)
    target_company_connect = target_company.company_connects.create(connect_id: connect.id)
    topic = connect.topics.create(topic_params)
    message = topic.messages.create(message_params)
    message.update(company_user: current_company_user)
    redirect_to topic_path(topic, before_page_type: params[:before_page_type])
  end

  def update
    @connect = current_company.connects.find(params[:id])
    target_company = @connect.get_target_company(current_company)
    @connect.update(connect_params(current_company.id, target_company.id))
    if params[:topic_id]
      flash[:success] = "#{target_company.name}へ取引開始申請しました。"
      redirect_to topic_path(params[:topic_id])
    else
      flash[:success] = "#{target_company.name}へ取引開始申請しました。"
      redirect_to company_connects_path
    end
  end

  def connect_params(current_company_id, target_company_id)
    params.permit(:contact_status).merge(from_company_id: current_company_id, to_company_id: target_company_id)
  end

  def connect_params_of_create(current_company_id, target_company_id)
    params.require(:connect).permit(:contact_status).merge(from_company_id: current_company_id, to_company_id: target_company_id)
  end

  def topic_params
    params.require(:topic).permit(:title, :topic_variety)
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
