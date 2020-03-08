class PicturesController < ApplicationController
  def new
    @order = current_user.japanese_retailer_orders.find(params[:order_id])
    @picture = @order.pictures.new
  end

  def create
    @order = current_user.japanese_retailer_orders.find(params[:order_id])
    @picture = @order.pictures.create(picture_params)
  end

  def edit
    @order = current_user.japanese_retailer_orders.find(params[:order_id])
    @picture = @order.pictures.find(params[:id])
  end

  def update
    @order = current_user.japanese_retailer_orders.find(params[:order_id])
    @picture = @order.pictures.find(params[:id])
    @picture.update(picture_params)
  end

  def destroy
    @order = current_user.japanese_retailer_orders.find(params[:order_id])
    @picture = @order.pictures.find(params[:id])
    @picture.destroy
  end

  private
  def picture_params
    params.require(:picture).permit(:url)
  end
end
