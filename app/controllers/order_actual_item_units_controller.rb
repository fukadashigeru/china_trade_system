class OrderActualItemUnitsController < ApplicationController
  def edit
    @order = current_company.japanese_retailer_orders.find(params[:id])
    @actual_item_units_and_taobao_urls_hash = @order.build_actual_item_units_and_taobao_urls
  end

  def update
    order = current_company.japanese_retailer_orders.find(params[:id])
    begin
      ActiveRecord::Base.transaction do
        order.processing_actual_item_units_and_taobao_urls(
          taobao_url_params,
          first_candidate_params,
          have_stock_params,
          current_company
        )
      end
      flash[:success] = "更新できました"
      redirect_to japanese_retailer_orders_path
    rescue
      flash[:danger] = "更新に失敗しました"
      redirect_to japanese_retailer_orders_path
    end
  end

  private
    def taobao_url_params
      params.require(:"taobao_url")
    end

    def first_candidate_params
      params[:"first_candidate_select"]
    end

    def have_stock_params
      params.require(:"have_stock")
    end
end
