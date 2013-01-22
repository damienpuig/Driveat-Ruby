class Reservationstate
  include Mongoid::Document
  field :name, type: String
  
  embedded_in  :reservation, :class_name => "Reservation", :inverse_of => :state
  attr_accessible :name
  validates_presence_of :name
  validates_uniqueness_of :name
end
