class OrderItemsController < ApplicationController
  before_action set_order_item, only: %i[edit update destroy]

  def index
  end

  def new
    @item = Item.find(params[:item_id])
  end

  def create
    @order_item = OrderItem.new(order_item_params)
  end

  def edit
  end

  def update
  end

  def destroy
    @order_item.destroy
  end
  private

  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def order_item_params
    params.require(:order_item).permit(:workshop_date_id, :item_id, :quantity, :price, :order_id)
  end
end
