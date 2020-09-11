class WorkshopDatesController < ApplicationController
  before_action :workshop_dates, only: %i[new destroy]

  def index
    @workshop_dates = WorkshopDate.all
  end

  def new
    @item = Item.find(params[:item_id])
    @workshop_date = WorkshopDate.new
    @workshop_date.item = @item
  end

  def create
    @item = Item.find(params[:item_id])
    @workshop_date = WorkshopDate.new(workshop_date_params)
    @workshop_date.item = @item

    if @workshop_date.save
      redirect_to new_item_workshop_date_path(@item), notice: 'Your dates were successfully created'
    else
      render :new, notice: 'workshop_date not saved!'
    end
  end

  def update
    @workshop_date = WorkshopDate.find(params[:id])
    @workshop_date.update(workshop_date_params)
    # authorize @workshop_date
    # if @workshop_date.save!
    #   notice: "workshop_date updated!"
    #  #redirect_to workshop_date_path(@workshop_date), notice: 'Your workshop_date was successfully updated.'
    # else
    #   notice: "workshop_date not updated"
    #  # render :new
    # end
  end

  def destroy
    @item = Item.find(params[:item_id])
    @workshop_date = WorkshopDate.find(params[:id])
    @workshop_date.destroy
    render :new
  end

  private

  def workshop_date_params
    params.require(:workshop_date).permit(:start_date, :end_date)
  end

  def workshop_dates
   @workshop_dates = WorkshopDate.where(item_id: params[:item_id])
  end
end
