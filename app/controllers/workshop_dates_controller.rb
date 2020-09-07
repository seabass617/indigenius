class WorkshopDatesController < ApplicationController
  def create
    @workshop_date = WorkshopDate.find(params[:id])
    @workshop_date.update(workshop_date_params)

    if @workshop_date.save!
     redirect_to  notice: 'Your dimension was successfully updated.' # Am I actually redirecting anywhere?
    else
     render :new # what should I render here if I am within the item new form?
    end 
  end

  def update

  end

  def destroy
    @workshop_date = WorkshopDate.find(params[:id])
    @workshop_date.destroy 
    redirect_to #where are you redirecting to?
  end

  private
  def workshop_date_params
      params.require(:workshop_date).permit(:start_date, :end_date)
  end  
end
