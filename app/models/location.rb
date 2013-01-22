class Location
  include Mongoid::Document
  include Geocoder::Model::Mongoid
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  reverse_geocoded_by :coordinates
  after_validation :reverse_geocode

  attr_accessible :address, :coordinates
  field :address, type: String
  field :coordinates, :type => Array

  embedded_in  :user, :class_name => "User", :inverse_of => :location
  
  
  
  def self.check_user_distance(user, address, distance)
     dist = Geocoder::Calculations.distance_between(address.coordinates, [user.location.coordinates[1], user.location.coordinates[0]])
     return dist 
  end

end
