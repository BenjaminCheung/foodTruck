class Truck < ActiveRecord::Base
  has_and_belongs_to_many :users

  def self.find_by_lat_long(latitude, longitude)
    #Rails.cache.fetch("#{latitude}#{longitude}", expires_in: 600) do
      endpoint_url = 'http://nyctruckfood.com/api/trucks-by-distance.json'
      response = RestClient.get("#{endpoint_url}?latlng=#{latitude},#{longitude}")
      json_response = JSON.parse(response)
      json_response.each do |item|
        # binding.pry
        Truck.new(item.name, item.twitter_handle);

      end
    #end
  end

  def self.with_favorites(user, latitude, longitude)

    # trucks = Truck.find_by_lat_long(latitude, longitude)
    trucks = Truck.find_by_lat_long(40.7393231, -73.9893836)
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