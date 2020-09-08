class OrdersController < ApplicationController

    def index
        @orders = Order.where(user: current_user)
    end   

#to do:implemnent status method  purchased, pending and cancelled// implement that the user can cancel if needed
# if user cancels  set status to cancelled. 
# if user completed set status to completed: validation
# if order pending set status to pending 
#discuss with team  method of how it would work 


    def total_price
       items.to_a.sum { |item| item.total_price }
    end

    private 
    def order_params 
    params.require(:order).permit(:status, :total_price)
    end     
end     


