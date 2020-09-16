class OrdersController < ApplicationController
  def index
    @orders = Order.where('user_id = ?', current_user.id)
    @order_pending = @orders.where(status: 'pending')
    @order_confirmed = @orders.where(status: 'confirmed')
    @order_cancelled = @orders.where(status: 'cancelled')
  end

  def show
    @items = Item.all
    @order = current_user.orders.find_by(status: 'pending')
    unless @order.nil?
      @order_items = OrderItem.where(order_id: @order.id)
      @total_price = total_price(@order.order_items)
      @order.total_price = @total_price
      @order.save
    end
  end

  def confirm
    @order = current_user.orders.find(params[:id])
    @order.status = 'pending'
    @order.save

    images = []
    @order.order_items.each do |order_item|
      order_item.item.images.each do |image|
        images << image.key
      end
    end
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: @order.user.email,
        images: [images],
        amount: @order.total_price_cents,
        currency: 'usd',
        quantity: 1
      }],
      success_url: orders_url(@order),
      cancel_url: order_url(@order)
    )

    @order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(@order)
    @order.status = "confirmed"
    @order.save
  end

  def cancel
    @order = current_user.orders.find(params[:id])
    @order.status = 'cancelled'
    @order.save
    flash[:notice] = "Order ##{@order.id} was cancelled."
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
