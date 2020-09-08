class OrderItemsController < ApplicationController
  before_action set_order_item, only: %i[edit update destroy]

  def index
    @current_order_items = OrderItem.where(order_id: current_user.order.id) #review this!
  end

  def new
    @item = Item.find(params[:item_id])
    @order_item = OrderItem.new
  end

  def create
    @order = current_user.order.find_or_create_by(status: 'open') #check what will be the options od status
    @item = Item.find(params[:item_id])

    @order_item = OrderItem.new(order_item_params)
    @order_item.order_id = @order.id
    @order_item.price = @item.price
    @order_item.save
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
