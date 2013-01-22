class User
  include Mongoid::Document
  scope :searchable, where(:location.exists => true).all
  
  field :username, type: String
  field :email, type: String
  field :password_hash, type: String
  field :password_salt, type: String
  field :firstname, type: String
  field :lastname, type: String
  field :aboutyou, type: String
  field :distance, type: Float

  mount_uploader :picture, PictureUploader
  embeds_one :location, :class_name => "Location", :inverse_of => :user, autobuild: true
  accepts_nested_attributes_for :location

  attr_accessible :_id, :username, :email, :password,
                  :password_confirmation, :firstname,
                  :lastname, :aboutyou, :location, :picture, :distance

  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email, :username
  def self.authenticate(email, password)
    user = User.where(:email => email).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
    user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def store_image(uploaded_file)
    uploader = PictureUploader.new
    if uploaded_file != nil
      Rails.logger.info self.picture
    uploader.store!(uploaded_file)
    self.picture = uploaded_file
    end
  end

  def set_safe_location(location)
    if location != nil
    self.location  = location
    end
  end

  def set_safe_picture(picture)
    if picture != nil
    self.store_image(picture)
    end
  end
  
  def to_nested
    return Nesteduser.new(:_id => self._id,  :email => self.email,  :username => self.username)
  end
end
