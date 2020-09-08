class DimensionsController < ApplicationController

    def index
        @orders = Order.where(user: current_user)
    end   


    private 
    def order_params 
    params.require(:oder).permit(:status, :total_price)
    end     
end     