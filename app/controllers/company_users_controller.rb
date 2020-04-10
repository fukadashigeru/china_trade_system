class CompanyUsersController < ApplicationController
  def update
    company_user = current_user.company_users.find(params[:id])
    company_user.update(invited_accepted: true)
    redirect_to companies_path
  end
end
