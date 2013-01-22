class Dish
  include Mongoid::Document
  field :name, type: String
  field :price, type: Float
  field :availability, type: DateTime
  field :food, type: String
  field :description, type: String
  field :distance, type: Float
  
  
  mount_uploader :picture, PictureUploader
  embeds_one :nesteduser, :class_name => "Nesteduser", store_as: "nesteduser"
  embeds_one :dishtype, :class_name => "Dishtype", autobuild: true, store_as: "dishtype"
  
  accepts_nested_attributes_for :nesteduser, :dishtype
  

  attr_accessible :name, :price, :availability, :food, :description, :dishtype, :nesteduser, :picture, :distance

  validates_presence_of :name, :price, :availability, :food, :description, :dishtype, :nesteduser
  
  def store_image(uploaded_file)
    uploader = PictureUploader.new
    if uploaded_file != nil
    uploader.store!(uploaded_file)
    self.picture = uploaded_file
    end
  end
  
  def self.dishes_by_nesteduser(uid)
    return self.where("nesteduser._id" => uid)
  end
  
  def self.dish_by_id(dishid)
    return self.where(:_id => dishid).first
  end
  
end