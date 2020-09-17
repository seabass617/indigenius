class PagesController < ApplicationController
  def home
    @items = Item.all
    @markers = Item.geocoded.map do |item|
      {
        lat: item.latitude,
        lng: item.longitude,
        infoWindow: render_to_string(partial: "items/info_window", locals: { item: item }),
        image_url: helpers.asset_url('location_icon_brown.png')
      }
    end
  end
end


