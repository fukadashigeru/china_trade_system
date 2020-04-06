class Users::InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  def new
    @company = current_user.companies.find(params[:company_id])
    super
  end

  def create
    @company = current_user.companies.find(params[:company_id])
    already_create_user = User.find_by(email: params[:user][:email])
    begin
      ApplicationRecord.transaction do
        if already_create_user
          @invited_company_user = already_create_user.invited_company_users.build(invited_company_user_params).tap do |invited_company_user|
            invited_company_user.company = @company
          end
          if @invited_company_user.validation_save
            flash[:success] = "招待しました"
            redirect_to companies_path
          end
        else
          super do |user|
            @invited_company_user = user.invited_company_users.build(invited_company_user_params).tap do |invited_company_user|
              invited_company_user.company = @company
            end
            if user.errors.empty?
              @invited_company_user.validation_save
            else
              render :new
              raise ActiveRecord::Rollback
            end
          end
        end
      end
    rescue
      flash[:danger] = "既に招待済みのため処理を完了できませんでした。"
      redirect_to companies_path
    end
  end

  def edit
    super
  end

  def update
    super
  end

  def destroy
    super
  end

  protected
  def configure_permitted_parameters
    #strong parametersを設定し、fname、gnameを許可
    devise_parameter_sanitizer.permit(:invite, keys: [:name])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name])
  end

  private
    def invited_company_user_params
      params.require(:invited_company_user).permit(:role)
    end

    def user_params
      params.require(:user).permit(:name)
    end
end
