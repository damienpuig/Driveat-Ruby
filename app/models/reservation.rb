class Reservation
  include Mongoid::Document
  field :date, type: DateTime
  field :hour, type: DateTime
  Approved = "Approved"
  Declined = "Declined"
  CallintoConfirm = "Call in to confirm"
  Canceled = "Canceled"
  PaymentConfirm = "Payment Confirmed"

  embeds_one :state, :class_name => "Reservationstate", store_as:"state"
  embeds_one :buyer, :class_name => "Nesteduser", store_as: "buyer"
  embeds_one :dishconcerned, :class_name => "Dish", store_as: "dishconcerned"

  attr_accessible  :buyer, :state, :dishconcerned, :date, :hour
  validates_presence_of :buyer, :state, :dishconcerned, :date, :hour
  def self.Reserve(date, hour, dishid, buyerid)
    newReservation = self.new(:date => date, :hour => hour)
    newReservation.dishconcerned = Dish.where(:_id => dishid).first
    buyer = User.where(:_id => buyerid).first
    newReservation.buyer = Nesteduser.new(:_id => buyer._id, :username => buyer.username, :email => buyer.email)
    newReservation.state = Reservationstate.new(:name => CallintoConfirm)
    newReservation.save!
  end

  def self.Decline(reservationid)
    reservation = get_reservation_by_id(reservationid)
    reservation.state = Reservationstate.new(:name => Declined)
    reservation.save!
    return reservation
  end

  def self.Cancel(reservationid)
    reservation = get_reservation_by_id(reservationid)
    reservation.state = Reservationstate.new(:name => Canceled)
    reservation.save!
    return reservation
  end

  def self.Reconsider(reservationid)
    reservation = get_reservation_by_id(reservationid)
    reservation.state = Reservationstate.new(:name => CallintoConfirm)
    reservation.save!
    return reservation
  end

  def self.Approve(reservationid)
    reservation = get_reservation_by_id(reservationid)
    reservation.state = Reservationstate.new(:name => Approved)
    reservation.save!
    return reservation
  end

  def self.get_reservation_by_id(reservationid)
    reservation = Reservation.where(:_id => reservationid).first
    return reservation
  end

  def self.MyReservations(uid)
    return Reservation.where('buyer._id' => uid)
  end

  def self.MySales(uid)
    return Reservation.where('dishconcerned.nesteduser._id' => uid)
  end

  def is_Approved?
    self.state.name == Approved
  end

  def is_Declined?
    self.state.name == Declined
  end

  def is_CallintoConfirm?
    self.state.name == CallintoConfirm
  end

  def is_Canceled?
    self.state.name == Canceled
  end

  def is_PaymentConfirm?
    self.state.name ==PaymentConfirm
  end

end