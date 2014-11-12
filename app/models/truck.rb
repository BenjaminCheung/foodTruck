class Truck < ActiveRecord::Base

  def self.find_by_lat_long(latitude, longitude)
    #Rails.cache.fetch("#{latitude}#{longitude}", expires_in: 600) do
      endpoint_url = 'http://nyctruckfood.com/api/trucks-by-distance.json'
      response = RestClient.get("#{endpoint_url}?latlng=#{latitude},#{longitude}")
      JSON.parse(response)
    #end
  end

  def self.with_favorites(user, latitude, longitude)

    trucks = Truck.find_by_lat_long(latitude, longitude)
    favorites = user.favorite_truck_names
    trucks.map do |truck|
      uname = truck['obj']['uname']
      truck.merge!(favorite: true) if favorites.include? uname
      truck
    end
  end
end


# brooks = User.new
# Truck.with_favorite(brooks, 40.7393231, -73.9893836)