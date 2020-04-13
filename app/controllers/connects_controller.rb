class ConnectsController < ApplicationController
  def update
    @connect = current_company.connects.find(params[:id])
    target_company = @connect.get_target_company(current_company)
    @connect.update(connect_params(current_company.id, target_company.id))
    if params[:topic_id]
      flash[:success] = "#{target_company.name}へ買付代行取引開始申請しました。"
      redirect_to topic_path(params[:topic_id])
    else
      flash[:success] = "#{target_company.name}へ買付代行取引開始申請しました。"
      redirect_to company_connects_path
    end
  end

  def connect_params(current_company_id, target_company_id)
    params.permit(:contact_status).merge(from_company_id: current_company_id, to_company_id: target_company_id)
  end
end
