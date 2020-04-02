class InvitedCompanyUsersController < ApplicationController
  def new
    @company = current_user.companies.find(params[:company_id])
  end
end
