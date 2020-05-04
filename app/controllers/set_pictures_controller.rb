class SetPicturesController < ApplicationController
  def new
    @item_set = current_company.item_sets.find(params[:item_set_id])
    @color_size_price_images = @item_set.color_size_price_images
    @order = current_company.japanese_retailer_orders.find(params[:order_id])
  end

  def create
    item_set = current_company.item_sets.find(params[:item_set_id])
    color_size_price_images = item_set.color_size_price_images
    order = current_company.japanese_retailer_orders.find(params[:order_id])
    begin
      ActiveRecord::Base.transaction do
        if params["color_size_price_image"]
          color_size_price_image_params.keys.each do |i_to_s|
            i = i_to_s.to_i
            color_size_price_image = color_size_price_images.find(i)
            order.pictures.create(url: color_size_price_image.image, color_size_price_image: color_size_price_image)
          end
        end
      end
      flash[:success] = "画像を選択できました。"
      redirect_to japanese_retailer_orders_path(order_id: order.id)
    rescue
      flash[:danger] = "画像を選択できませんでした。"
      redirect_to japanese_retailer_orders_path(order_id: order.id)
    end
  end

  private
  def color_size_price_image_params
    params.require(:color_size_price_image)
  end
end
