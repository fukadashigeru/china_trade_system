class ChineseBuyerOrdersController < ApplicationController
  before_action :ensure_current_company

  def index
    if params[:japanese_retailer_id]
      @orders_temp = current_company.chinese_buyer_orders.includes(:item_set).order(id: "ASC")
      @orders = @orders_temp.select{|x| x.japanese_retailer_id == params[:japanese_retailer_id].to_i}
    else
      @orders = current_company.chinese_buyer_orders.includes(:item_set).order(id: "ASC")
    end
  end
end
