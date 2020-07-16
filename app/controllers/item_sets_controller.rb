class ItemSetsController < ApplicationController
  def edit
    @order = current_company.japanese_retailer_orders.find(params[:order_id])
    @item_set = current_company.item_sets.find(params[:id])
    @item_units_and_taobao_urls_hash = @item_set.build_item_units_and_taobao_urls
    @color_size_price_images = @item_set.build_color_size_price_images
  end

  def update
    order = current_company.japanese_retailer_orders.find(params[:order_id])
    item_set = current_company.item_sets.find(params[:id])
    begin
      ActiveRecord::Base.transaction do
        item_set.processing_item_units_and_taobao_urls(
          taobao_url_params,
          first_candidate_params,
          have_stock_params,
          current_company,
          remove_taobao_url_params,
          remove_item_unit_params
        )
        item_units = item_set.item_units.includes(:taobao_urls)
        item_set.orders.each do |order|
          if order.actual_item_units.empty?
            item_units.each do |item_unit|
              actual_item_unit = order.actual_item_units.create(first_candidate_id: item_unit.first_candidate_id)
              actual_taobao_urls = actual_item_unit.taobao_urls
              item_unit.taobao_urls.each do |taobao_url|
                if !actual_taobao_urls.include?(taobao_url)
                  actual_item_unit.actual_item_unit_taobao_urls.create(taobao_url: taobao_url)
                end
              end
            end
          end
        end
        item_set.create_and_update_color_size_price_images(color_size_price_image_params)
      end
      flash[:success] = "更新できました"
      # redirect_back
      redirect_to japanese_retailer_orders_path(order_id: order.id)
    rescue
      flash[:danger] = "更新に失敗しました"
      redirect_to japanese_retailer_orders_path(order_id: order.id)
    end
  end

  def search
    @item_set = ItemSet.find_or_initialize_by(company_id: current_company.id, item_no: params[:item_no], item_no_category: params[:item_no_category])
  end

  private
    def taobao_url_params
      params.require(:"taobao_url")
    end

    def first_candidate_params
      # params.require(:"first_candidate_select")
      params[:"first_candidate_select"]
    end

    def have_stock_params
      params.require(:"have_stock")
    end

    def remove_taobao_url_params
      if params[:"remove_taobao_url"]
        params.require(:"remove_taobao_url")
      end
    end

    def remove_item_unit_params
      if params[:"remove_item_unit"]
        params.require(:"remove_item_unit")
      end
    end

    def color_size_price_image_params
      params[:color_size_price_image]
    end
end

