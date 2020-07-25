class CompanyUserRolesController < ApplicationController
  def edit
    @company_user = CompanyUser.find(params[:id])
  end

  def update
    company_user = CompanyUser.find(params[:id])
    company_user.update(company_user_params)
    redirect_to company_path(company_user.company)
  end

  private

  def company_user_params
    params.require(:company_user).permit(:role)
  end
end
