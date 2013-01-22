class Nesteduser
  include Mongoid::Document
  field :username, type: String
  field :email, type: String
  
  attr_accessible :username, :_id, :email
  
  end
  