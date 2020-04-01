class TaobaoColorSizesController < ApplicationController
  def new
    @order = current_company.japanese_retailer_orders.find(params[:order_id])
    @taobao_color_size = @order.build_taobao_color_size
  end

  def create
    @order = current_company.japanese_retailer_orders.find(params.require(:taobao_color_size)[:order_id])
    if @order.create_taobao_color_size(taobao_color_size_params)
      render "create"
    else
      render "create"
    end
  end

  def edit
    @taobao_color_size = TaobaoColorSize.find(params[:id])
  end

  def update
    @order = current_company.japanese_retailer_orders.find(params.require(:taobao_color_size)[:order_id])
    if @order.taobao_color_size.update(taobao_color_size_params)
      render "update"
    else
      render "update"
    end
  end
  
  private
    def taobao_color_size_params
      params.require(:taobao_color_size).permit(
        :name,
        :order_id
        )
    end

end
