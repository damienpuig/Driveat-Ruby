class LocationsController < ApplicationController
  #Search by location and distance on index. Different from List in MVC4 MSFx
  def index
    
   @disasm = RubyVM::InstructionSequence.disasm(method(:index))
    print RubyVM::InstructionSequence.disasm(method(:index))
    # In that case, if the user doesn't enter a value, the research goes through all the dishes.... and that is wrong.
    # The search needs to be redirected in that case.
    if params[:search].present?

      #Get the current address searched by the Geocoder service, setting right coordinates.
      current = Geocoder.coordinates(params[:search])

      #Setting a temporal location entity by adding coordinates to it.
      templocation = Location.new(:coordinates => current)

      #SEARCH REQUEST:
      # The search request in rails handles lots of requests and it is not well developed due to some
      #technical issues in request possibilities. This search can be really improved.

      #Get all of the users with a setted location property.
      @users = User.searchable

      #Initialise 2 arrays:
      # The first array corresponds to  valid users depending on coordinates.
      # The second array corresponds to valid dish for given user.
      availableuser = Array.new
       availabledish = Array.new

      #First foreach
      @users.each do |user|

      #Retreive distance between valid user and entry
        distanceBetween = Location.check_user_distance(user, templocation, params[:distance])

        #temporal set on user distance ready to be displayed (not done in MVC4 MSFx)
        user.distance = distanceBetween

        # append the valid user only if the distance is less than the entry scope
        availableuser.append(user) if distanceBetween < params[:distance].to_f
        
      end

      # For each available user, retreive dishes and format entries.
      availableuser.each do |avuser|

      #retreives the dish.
        currentdish = Dish.dishes_by_nesteduser(avuser._id)

        currentdish.each do |d|
          d.distance = avuser.distance
          d.food = substring(d.food);
          d.description = substring(d.description)
          availabledish.append(d)
        end
      end

      #set the dish list.
      @dishes = availabledish
    else
      @dishes = Dish.all
    end

  end
end