class Dishtype
  include Mongoid::Document
  field :name, type: String
  
  attr_accessible :name
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  def self.find_by_id(dishtypeid)
    return self.find(dishtypeid)
  end
  
end
