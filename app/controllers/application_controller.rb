class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current

  # add_flash_types :success, :info, :warning, :danger

  def ensure_current_cumpany
    return if @current_company

    flash[:danger] = '会社にログインしてください'
    redirect_to companies_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :account_type])
  end

  def set_current
    @current_company = current_company
  end
end
