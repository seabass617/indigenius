class OrderItemsController < ApplicationController
  def new
    @item = Item.find(params[:item_id])

    if @item.workshop?
      @workshop_date = WorkshopDate.find(params[:workshop_date_id])
    else
      @item
    end
  end

  def create
  end

  def edit
    @order_item = OrderItem.find(params[:id])
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
  end

  def order_item_params
    params.require(:order_item).permit(:workshop_date_id, :item_id, :quantity, :price, :order_id)
  end
end
