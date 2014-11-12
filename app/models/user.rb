class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #has_many :favorites
  # has_many :favorites, through: :trucks
  # has_many :trucks, through :trucks_users
  #make truck_users table for favorites

  def favorite_truck_names
    #favorites.pluck(:uname)
    ['go_burger']
  end
end
