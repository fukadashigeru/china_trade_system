class JapaneseRetailerOrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :ensure_current_company
  
  # GET /orders
  # GET /orders.json
  def index
    @orders = current_company.japanese_retailer_orders.includes(:item_set).order(id: "ASC").page(params[:page]).per(10)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  # def edit
  #   @order = current_user.japanese_retailer_orders.find(params[:id])
  # end

  def edit
    @order = current_company.japanese_retailer_orders.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  # def update
  #   @order = Order.find(params[:id])
  #   if @order.update(order_params)
  #     render "update"
  #   else
  #     render "edit"
  #   end
  # end

  def update
    #モーダルページで、保存済みのpictureのidがparamsに乗ってこなかったら、削除する
    @order.remove_pictures_of_not_included_in_params(order_params)
    if @order.update(order_params)
      flash[:success] = "保存できました"
      redirect_to japanese_retailer_orders_path(order_id: @order.id)
    else
      flash[:alert] = '保存できませんでした。'
      redirect_to japanese_retailer_orders_path(order_id: @order.id)
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    chinese_buyer = Company.find(params[:chinese_buyer_id])
    begin
      ActiveRecord::Base.transaction do
        @orders = Order.import(params[:csv_file], current_company, chinese_buyer)
      end
      flash[:success] = "インポートに成功しました。"
      redirect_to japanese_retailer_orders_path
    rescue
      flash[:danger] = "インポートに失敗しました。"
      redirect_to japanese_retailer_orders_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(
        :quantity,
        :price,
        :postal,
        :address,
        :customer_name,
        :phone,
        :color_size,
        :estimate_charge,
        taobao_color_size_attributes: [:id, :name],
        pictures_attributes: [:id, :url]
        )
    end
end
