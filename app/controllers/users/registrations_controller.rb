class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_account_params, if: :devise_controller?
  before_action :require_no_authentication, only: :thanks

  def new
    @user = User.new
    super
  end

  def create
    super
  end

  def thanks; end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
  #   devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
  # end

  # The path used after sign up for inactive accounts. You need to overwrite
  # this method in your own RegistrationsController.
  def after_inactive_sign_up_path_for(resource)
    scope = Devise::Mapping.find_scope!(resource)
    router_name = Devise.mappings[scope].router_name
    context = router_name ? send(router_name) : self
    context.respond_to?(:thanks_path) ? context.thanks_path : '/'
  end
end
