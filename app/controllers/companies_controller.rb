class CompaniesController < ApplicationController
  def index
    session[:current_company_id] = nil
    owner_company_users_accepted = current_user.company_users.where(invited_accepted: true).includes(:user, :company).select{|x| x.role == "owner"}
    belong_company_users_accepted = current_user.company_users.where(invited_accepted: true).includes(:user, :company).select{|x| x.role != "owner"}
    @company_users_accepted = owner_company_users_accepted + belong_company_users_accepted
    @company_users_unaccepted = current_user.company_users.where(invited_accepted: false)
  end

  def show
    @company = current_user.companies.find(params[:id])
    @company_users = @company.company_users
  end

  def new
    @company = current_user.companies.build
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        company_user = current_user.company_users.build(role: 0, invited_accepted: true).tap do |company_user|
          company_user.company = Company.create(company_params)
        end
        if company_user.save
          flash[:success] = "会社を登録しました"
          redirect_to companies_path
        end
      end
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
      end
      flash[:success] = "会社を更新しました"
      redirect_to company_path(company)
    rescue
      flash[:danger] = "会社を更新できませんでした"
      redirect_to company_path(company)
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
      params.require(:company).permit(:name, :owner_user_id, :account_type)
    end 
end
