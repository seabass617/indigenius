class PagesController < ApplicationController
  def home
    @items = Item.all
    @markers = Item.geocoded.map do |item|
      {
        lat: item.latitude,
        lng: item.longitude,
        infoWindow: render_to_string(partial: "items/info_window", locals: { item: item })
      }
    end
  end
end


