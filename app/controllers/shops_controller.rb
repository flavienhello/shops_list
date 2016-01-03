class ShopsController < ApplicationController

  def index
    @location = Location.new
    @shops = Shop.all.first(10)
  end

  def find
    @location = Location.new location_param

    if @location.address
      latlng = Geocoder.coordinates(@location.address)

      if latlng && latlng.count == 2
        @location.lat = latlng.first
        @location.lng = latlng.last
      end
    end

    if @location.validate
      if @location.range.present?
        @shops = Shop.near( [@location.lat, @location.lng], @location.range, :units => :km)
      elsif @location.number.present?
        @shops = Shop.near( [@location.lat, @location.lng]).first(@location.number.to_i)
      end
    else
      @shops = []
    end

    render 'shops/index'
  end

  private

  def location_param
    params.require(:location).permit(:lat, :lng, :address, :number, :range)
  end

end
