class OrderManualInputsController < ApplicationController
  def new
    @orders = 5.times.map { current_user.japanese_retailer_orders.build }
  end

  def create
    params[:submit_true].keys.each do |i|
      current_user.japanese_retailer_orders.create(order_params(i))
    end
    redirect_to "/"
  end

  private
    def order_params(i)
      params.require(i).permit(
        :trade_no,
        :postal,
        :address,
        :customer_name,
        :phone,
        :color_size,
        :quantity,
        :customer_remark,
        :japanese_retailer_remark,
      ).merge(chinese_buyer_id: params[:chinese_buyer_id])
    end
end
