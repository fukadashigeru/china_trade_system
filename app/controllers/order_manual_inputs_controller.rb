class OrderManualInputsController < ApplicationController
  def new
    @order = current_user.japanese_retailer_orders.build
    binding.pry
  end
end
