class ItemSetsController < ApplicationController
  def edit
    @item_set = current_company.item_sets.find(params[:id])
    @item_units_and_taobao_urls_hash = @item_set.build_item_units_and_taobao_urls
  end

  def update
    item_set = current_company.item_sets.find(params[:id])
    begin
      ActiveRecord::Base.transaction do
        item_set.processing_item_units_and_taobao_urls(
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
end
