class WorkshopDatesController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @workshop_date = WorkshopDate.new(workshop_date_params)
    @workshop_date.item = @item

    if @workshop_date.save!
      notice: "workshop_date saved!"
      # redirect_to  notice: 'Your dimension was successfully updated.' # Am I actually redirecting anywhere?
    else
     # render :new # what should I render here if I am within the item new form?
     notice: "workshop_date not saved!"
    end 
  end

  def update
    @workshop_date = WorkshopDate.find(params[:id])
    @workshop_date.update(workshop_date_params)
    #authorize @workshop_date
    if @workshop_date.save!
      notice: "workshop_date updated!"
     #redirect_to workshop_date_path(@workshop_date), notice: 'Your workshop_date was successfully updated.'
    else
      notice: "workshop_date not updated"
     # render :new
    end 

  end

  def destroy
    @workshop_date = WorkshopDate.find(params[:id])
    @workshop_date.destroy 
    #redirect_to #where are you redirecting to?
    notice: "sucessfully destroyed"
  end

  private
  def workshop_date_params
      params.require(:workshop_date).permit(:start_date, :end_date)
  end  
end
