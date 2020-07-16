class ConnectAuthorizationsController < ApplicationController
  def update
    connect = current_company.connects.find(params[:id])
    target_company = connect.companies.find(params[:company_id])
    if params[:topic_id]
      if connect.to_company == current_company && connect.from_company == target_company
        connect.update(contact_status: 'trade')
        flash[:success] = "#{target_company.name}様からの取引開始申請を承認しました。"
        redirect_to topic_path(params[:topic_id], before_page_type: params[:before_page_type])
      end
    else
      if connect.to_company == current_company && connect.from_company == target_company
        connect.update(contact_status: 'trade')
        flash[:success] = "#{target_company.name}様からの取引開始申請を承認しました。"
        redirect_to company_connects_path
      end
    end
  end
end
