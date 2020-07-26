class CompanyUsersController < ApplicationController
  def update
    company_user = current_user.company_users.find(params[:id])
    company_user.update(invited_accepted: true)
    redirect_to companies_path
  end

  def destroy
    company_user = CompanyUser.find(params[:id])
    company_user.destroy
    redirect_to company_path(params[:company_id])
  end
end
