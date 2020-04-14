class ConnectDeletesController < ApplicationController
  def update
    @connect = current_company.connects.find(params[:id])
    if @connect.update(from_company_id: nil, to_company_id: nil, contact_status: "only_message")
      if params[:topic_id]
        flash[:info] = "申請を取り消しました。"
        redirect_to topic_path(params[:topic_id], before_page_type: params[:before_page_type])
      else
        flash[:info] = "申請を取り消しました。"
        redirect_to company_connects_path
      end
    else
      flash[:danger] = "処理に失敗しました。"
      redirect_to company_connects_path
    end
  end
end
