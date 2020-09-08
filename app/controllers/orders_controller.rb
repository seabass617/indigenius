class OrdersController < ApplicationController

    def index
        @orders = Order.where(user: current_user)
    end   

#to do:implemnent status method  purchased, pending and cancelled
#to do: implement price calculation
    private 
    def order_params 
    params.require(:order).permit(:status, :total_price)
    end     
end     


