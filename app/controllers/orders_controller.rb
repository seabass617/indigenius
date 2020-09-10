class OrdersController < ApplicationController

    def index
        @orders = Order.where(user: current_user)
    end   

#to do:implemnent status method  purchased, pending and cancelled// implement that the user can cancel if needed
# if user cancels  set status to cancelled. 
# if user completed set status to completed: validation
# if order pending set status to pending 
#discuss with team  method of how it would work 

#pending by default 
#completed  when the buyer presses the purchase button 
#cancelled when cancelled from the buyer's or the seller's side.

# completed and purchased button will be in the order items controller 

def update 
    #only the seller can update in case of cancellation 
    #for both items
    #reimburse the money 
    #update the status of the order to cancelled 
    #update for pending and cancel is the same thing 
end 


def destroy
    @order_items= OrderItem.find(params[:order_items]) 
    @order = Order.new(order_params)
    @order = @order_items
    @order_items = @order.item_id
    @order.item_id.destroy
end

# #def status
#  # if  @order.current_user
#    #@order.status = 'completed'
# # 
#    elsif destroy
#     @order.status = 'cancelled'
  
#     else pending
 
#         @order.status = 'pending'
#  #clicks on btn  
    
# end     


    def total_price
       items.to_a.sum { |item| item.total_price }
    end

    private 
    def order_params 
    params.require(:order).permit(:status, :total_price)
    end     
end     


