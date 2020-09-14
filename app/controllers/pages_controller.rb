class PagesController < ApplicationController
  def home
    
     @markers = Item.geocoded.map do |item|
      {
        lat: item.latitude,
        lng: item.longitude
      }
    end
  end
end
