class ConnectOffersController < ApplicationController
  def update
    @connect = current_company.connects.find(params[:id])
    target_company = @connect.get_target_company(current_company)
    @connect.update(contact_status: "offer", from_company_id: current_company.id, to_company_id: target_company.id)
    if params[:topic_id]
      flash[:success] = "#{target_company.name}へ取引開始申請しました。"
      redirect_to topic_path(params[:topic_id], before_page_type: params[:before_page_type])
    else
      flash[:success] = "#{target_company.name}へ取引開始申請しました。"
      redirect_to company_connects_path
    end
  end
end
