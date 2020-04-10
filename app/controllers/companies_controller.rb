class CompaniesController < ApplicationController
  def index
    session[:current_company_id] = nil
    @owner_company_users = current_user.company_users.includes(:user).select{|x| x.role == "owner"}
    @belong_company_users = current_user.company_users.includes(:user).select{|x| x.role != "owner"}
    # @invited_company_users = current_user.invited_company_users.includes(:company)
  end

  def new
    @company = current_user.companies.build
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        company = current_user.companies.create(company_params)
        company_user = current_user.company_users.find_by(company_id: company.id)
        company_user.update(role: 0)
      end
      flash[:success] = "会社を登録しました"
      redirect_to companies_path
    rescue
      flash[:danger] = "会社を登録できませんでした"
      redirect_to companies_path
    end
  end

  def edit
    @company =  current_user.companies.find(params[:id])
  end

  def update
    company = current_user.companies.find(params[:id])
    begin
      ActiveRecord::Base.transaction do
        company.update(company_params)
        params["company_user"]&.each do |k, v|
          if v == "false"
            company_user = company.company_users.find(k.to_i)
            company_user.destroy
          end
        end
        params[:invited_company_user]&.each do |k, v|
          if v == "false"
            # invited_company_user = company.invited_company_users.find(k.to_i)
            # invited_company_user.destroy
          end
        end
      end
      flash[:success] = "会社を更新しました"
      redirect_to companies_path
    rescue
      flash[:danger] = "会社を更新できませんでした"
      redirect_to companies_path
    end
  end

  def login
    current_company = current_user.companies.find(params.require(:company_id))
    if current_company
      session[:current_company_id] = current_company.id
      flash[:success] = '会社にログインしました'
    end
    redirect_to root_path
  end

  def logout
    session[:current_company_id] = nil
    redirect_to companies_path
  end

  private
    def company_params
      params.require(:company).permit(:name, :owner_user_id, :is_japanese_retailer_account, :is_chinese_buyer_account)
    end 
end
