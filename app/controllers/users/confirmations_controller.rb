class Users::ConfirmationsController < Devise::ConfirmationsController
  # before_action :set_minimum_password_length, only: [:show, :confirm]

  def show
    current_resource = send(:"current_#{resource_name}")
    prev_resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key) if current_resource

    self.resource = resource_class.find_by(confirmation_token: params[:confirmation_token])
    super if resource.nil? || resource.confirmed?
  end

  def confirm
    confirmation_token = params[resource_name][:confirmation_token]
    self.resource = resource_class.find_by!(confirmation_token: confirmation_token)
    if resource.update(confirm_params)
      self.resource = resource_class.confirm_by_token(confirmation_token)
      set_flash_message :notice, :signed_up
      sign_in_and_redirect(resource_name, resource)
    else
      render action: 'show'
    end
  end

  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
    thanks_path
  end

  private

  def confirm_params
    params.require(resource_name).permit(:name, :password, :password_confirmation)
  end
end
