class OrderItemsController < ApplicationController
  before_action :set_order_item, only: %i[edit update destroy]

  def index
    @current_order_items = OrderItem.where(order_id: current_user.order.id)
  end

  def create
    @order = current_user.orders.find_or_create_by(status: 'pending')
    @item = Item.find(params[:item_id])

    @order_item = OrderItem.new(order_item_params)
    @order_item.item = @item
    @order_item.order = @order
    @order_item.price = order_item_price(@item)
    @order_item.save

    redirect_to order_path(@order)
  end

  def order_item_price(item)
    if item.workshop
      @item.price
    else
      @item.price * @order_item.quantity
    end
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
    params.require(:order_item).permit(:workshop_date_id, :quantity)
  end
end
