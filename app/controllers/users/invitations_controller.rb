class Users::InvitationsController < Devise::InvitationsController
  def new
    @company = current_user.companies.find(params[:company_id])
    super
  end

  def create
    @company = current_user.companies.find(params[:company_id])
    ApplicationRecord.transaction do
      super do |user|
        @invited_company_user = user.invited_company_users.build(invited_company_user_params).tap do |invited_company_user|
          invited_company_user.company = @company
        end

        if user.errors.blank? && @invited_company_user.save
          # user.deliver_invitation
          # @current_fyear.fyear_status.update!(user_invited_at: Time.zone.now) if @current_fyear

          # # 最新の規約に同意済みのオブジェクトを生成
          # ReadNews.create(user: user, news: News.latest_terms)
          # redirect_to companies_path
        else
          render :new
          raise ActiveRecord::Rollback
        end
      end
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

  private
    def invited_company_user_params
      params.require(:invited_company_user).permit(:role)
    end
end
