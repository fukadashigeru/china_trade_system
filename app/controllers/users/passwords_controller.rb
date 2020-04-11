class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create
    user = User.find_by(email:params[:user][:email])
    if user&.invitation_token.present?
      flash[:danger] = I18n.t('devise.failure.invitation_unaccepted')
      redirect_to new_user_password_path
    elsif !user.confirmed?
      flash[:danger] = I18n.t('devise.failure.unconfirmed')
      redirect_to new_user_password_path
    else
      super
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  def after_resetting_password_path_for(resource)
    root_path
  end

  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
    thanks_path
  end
end
