class OrdersController < ApplicationController

    def index
        @orders = Order.where("user_id = ?", current_user.id )
    end

    def show
        @order = current_user.orders.find_by(status: 'pending')
        @total_price = total_price(@order)
    end

    def confirm
        @order = current_user.orders.find_by(status: 'pending')
        @order.status = 'confirmed'
        @order.save

        redirect_to orders_path
    end 

    def update
        @order = current_user.orders.find_by(status: 'pending')
    end 

    def destroy
        @order_items= OrderItem.find(params[:order_items]) 
        @order = Order.new(order_params)
        @order = @order_items
        @order_items = @order.item_id
        @order.item_id.destroy
    end
  

    def total_price(order)
        #an if else to multiply products price by their quantity.
        total_price = 0
        order.order_items.each do |order_item|
            total_price += order_item.price 
        end 
        
        total_price
    end

    private 
    def order_params 
    params.require(:order).permit(:status, :total_price)
    end     
end     


