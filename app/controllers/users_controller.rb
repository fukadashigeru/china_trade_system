class UsersController < ApplicationController
  before_action :ensure_current_company

  def index
  end
end
