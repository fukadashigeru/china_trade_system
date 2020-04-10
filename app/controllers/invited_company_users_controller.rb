class InvitedCompanyUsersController < ApplicationController
  # def new
  #   @company = current_user.companies.find(params[:company_id])
  # end

  # def create
  #   company = current_user.companies.find(params[:company_id])
  #   begin
  #     ActiveRecord::Base.transaction do
  #       user = User.find_by(email: params[:email])
  #       if user
  #         InvitedCompanyUser.create(invited_company_user_params(user, company))
  #         flash[:success] = "招待しました"
  #         redirect_to japanese_retailer_orders_path
  #       end
  #     end
  #   rescue
  #     flash[:danger] = "招待済みのため招待できませんでした"
  #     redirect_to japanese_retailer_orders_path
  #   end
  # end

  def destroy
    # @invite_company_users = current_user.invited_company_users.find(params[:id])
    begin
      ActiveRecord::Base.transaction do
        current_user.company_users.create(
          company_id: @invite_company_users.company_id,
          role: @invite_company_users.role,
        )
        @invite_company_users.destroy
        flash[:success] = "招待を認証しました"
        redirect_to japanese_retailer_orders_path
      end
    rescue
      flash[:danger] = "招待を認証できませんでした"
      redirect_to japanese_retailer_orders_path
    end
  end

  # def new_invite_user
  #   @company = current_user.companies.find(params[:company_id])
  # end

  # def create_invite_user
  #   user = User.find_by(email: params[:email])
  #   company = current_user.companies.find(params[:company_id])
  #   company_users = company.company_users.find_by(user_id: user.id)
  #   if company_users
  #     company_users.update(role: params[:role].to_i)
  #   else
  #     company.company_users.create(user_id: user.id, role: params[:role].to_i)
  #   end
  #   redirect_to companies_path
  # end

  private
    def invited_company_user_params(user, company)
      params.require(:invited_company_user).permit(:role).merge(user_id: user.id, company_id: company.id)
    end
end
