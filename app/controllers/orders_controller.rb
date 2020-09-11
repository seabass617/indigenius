class OrdersController < ApplicationController
  def index
    @orders = Order.where('user_id = ?', current_user.id)
    @order_pending = @orders.where(status: 'pending')
    @order_confirmed = @orders.where(status: 'confirmed')
    @order_cancelled = @orders.where(status: 'cancelled')
  end

  def show
    @order = current_user.orders.find_by(status: 'pending')
    unless @order.nil?
      @total_price = total_price(@order.order_items) 
      @order.total_price = @total_price
      @order.save
    end
  end

  def confirm
    @order = current_user.orders.find(params[:id])
    @order.status = 'confirmed'
    @order.save

    redirect_to orders_path
  end

  def cancell
    @order = current_user.orders.find(params[:id])
    @order.status = 'cancelled'
    @order.save

    redirect_to orders_path
  end

  def total_price(order_items_array)
    total_price = 0
    order_items_array.each do |order_item|
      total_price += order_item.price
    end
    total_price
  end

  private

  def order_params
    params.require(:order).permit(:status, :total_price)
  end
end
