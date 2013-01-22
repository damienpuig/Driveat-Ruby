class UsersController < ApplicationController
  # Controller dependent of authentication
  before_filter :require_login
  
  # Account/ showing user informations.
  def index
    # Retreive the user id
    uid = @current_user._id
    
    #set user model
    @user = User.find(uid)
    
    #set user dishes by user id
    @dishes = Dish.dishes_by_nesteduser(uid)
    
    #set reservations by user id
    @reservations = Reservation.MyReservations(uid)
    
    #set sales by user id
    @sales = Reservation.MySales(uid)
  end
  
  # User/Show displaying user information
  def show
    
    #find user by username
    @user = User.where(:username => params[:username]).first
    
    #affect dishes.
    @dishes = Dish.dishes_by_nesteduser(@user._id)
  end

 # Update post action.
  def update
    #get user id depending on the opened session
    uid = @current_user._id
    
    # get current user to be updated
    @user = User.find(uid)
    
    # Update the location in a safely way
    @user.set_safe_location(params[:location])
    
    # update the picture in a safely way
    @user.set_safe_picture(params[:picture])

  #Save the model and redirect back to the /Account
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to account_page_path, notice: 'User successfully updated.' }
      else
        format.html { render action: "index" }
      end
    end
  end
end
