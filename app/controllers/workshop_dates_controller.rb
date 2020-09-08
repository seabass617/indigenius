class WorkshopDatesController < ApplicationController
  
  def index 
    @workshop_dates = WorkshopDate.all
  end 

  def new
    @item = Item.find(params[:item_id])
    @workshop_date = WorkshopDate.new
    @workshop_date.item = @item 
    @workshop_dates = WorkshopDate.all
  end 
  
  def create
    @item = Item.find(params[:item_id])
    @workshop_date = WorkshopDate.new(workshop_date_params)
    @workshop_date.item = @item

    if @workshop_date.save
    redirect_to new_item_workshop_date_path(@item), notice: 'Your dates were successfully created' # Am I actually redirecting anywhere?
    else
      render :new, notice: "workshop_date not saved!" # what should I render here if I am within the item new form?
     
     end 
  end

  def update
    @workshop_date = WorkshopDate.find(params[:id])
    @workshop_date.update(workshop_date_params)
    #authorize @workshop_date
    # if @workshop_date.save!
    #   notice: "workshop_date updated!"
    #  #redirect_to workshop_date_path(@workshop_date), notice: 'Your workshop_date was successfully updated.'
    # else
    #   notice: "workshop_date not updated"
    #  # render :new
    # end 

  end

  def destroy
    @workshop_date = WorkshopDate.find(params[:id])
    @workshop_date.destroy 
    #redirect_to #where are you redirecting to?
    # notice: "sucessfully destroyed"
  end

  private
  def workshop_date_params
      params.require(:workshop_date).permit(:start_date, :end_date)
  end  
end
