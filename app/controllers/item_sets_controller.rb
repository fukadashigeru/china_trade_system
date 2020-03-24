class ItemSetsController < ApplicationController
  def edit
    @item_set = current_user.item_sets.find(params[:id])
    @item_units_and_taobao_urls_hash = @item_set.build_item_units_and_taobao_urls
  end

  def update
    item_set = current_user.item_sets.find(params[:id])
    begin
      ActiveRecord::Base.transaction do
        taobao_url_params.keys.each do |i|
          taobao_url_params[i].keys.each do |j|
            if j == "0"
              item_unit = item_set.item_units.create
            else
              item_unit = item_set.item_units.find(j.to_i)
            end
            taobao_url_params[i][j].keys.each do |k|
              taobao_url_params[i][j][k].keys.each do |l|
                taobao_url_url = taobao_url_params[i][j][k][l]
                ## TODO 空欄でも削除とかせな
                next unless taobao_url_params[i][j][k][l].present?
                if l == "0"
                  taobao_url = current_user.taobao_urls.find_or_create_by(url: taobao_url_url)
                  item_unit.item_unit_taobao_urls.create(taobao_url_id: taobao_url.id)
                else
                  taobao_url = item_unit.taobao_urls.find(l.to_i)
                  item_unit_taobao_url = ItemUnitTaobaoUrl.find_by(item_unit_id: j.to_i , taobao_url_id: l.to_i)
                  if taobao_url.item_units.length > 1
                    taobao_url = current_user.taobao_urls.find_or_create_by(url: taobao_url_url)
                    item_unit_taobao_url.update(taobao_url_id: taobao_url.id)
                  else
                    taobao_url.update(url: taobao_url_url)
                  end
                end
                if k == first_candidate_params
                  item_unit.update(first_candidate_id: taobao_url.id)
                end
                # binding.pry
                taobao_url.update(is_have_stock: have_stock_params[k].to_i)
              end
            end
          end
        end
      end
      flash[:success] = "更新できました"
      redirect_to root_path
    rescue
      flash[:danger] = "更新に失敗しました"
      redirect_to root_path
    end
  end

  def search
    @item_set = ItemSet.find_or_initialize_by(user_id: current_user.id, item_no: params[:item_no], item_no_category: params[:item_no_category])
  end

  private
    def taobao_url_params
      params.require(:"taobao_url")
    end

    def first_candidate_params
      ## チェックボックスが必ずどれか入れる仕様になったら、下記のコードに変更
      # params.require(:"first_candidate_select").keys.first
      params[:"first_candidate_select"].keys.first
    end

    def have_stock_params
      params.require(:"have_stock")
    end
end
