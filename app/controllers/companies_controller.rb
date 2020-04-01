class CompaniesController < ApplicationController
  def index
    session[:current_company_id] = nil
    @owner_company_users = current_user.company_users.includes(:user).select{|x| x.role == "owner"}
    @belong_company_users = current_user.company_users.includes(:user).select{|x| x.role != "owner"}
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

  def new_invite_user
    @company = current_user.companies.find(params[:company_id])
  end

  def create_invite_user
    user = User.find_by(email: params[:email])
    company = current_user.companies.find(params[:company_id])
    company_users = company.company_users.find_by(user_id: user.id)
    if company_users
      company_users.update(role: params[:role].to_i)
    else
      company.company_users.create(user_id: user.id, role: params[:role].to_i)
    end
    redirect_to companies_path
  end

  private
    def company_params
      params.require(:company).permit(:name, :owner_user_id)
    end 
end
