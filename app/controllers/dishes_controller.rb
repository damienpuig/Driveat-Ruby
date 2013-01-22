class DishesController < ApplicationController
before_filter :require_login


  # GET /dishes/new
  # Create a dish on Dish/New
  def new
    # Initialize a new model.
    @dish = Dish.new
    
    #Retreive all dish types.
    @dishtypes = Dishtype.all
  end
  
    # GET /dishes/new
    #Display a dish on Dish/Show given a dish id.
  def show
    #Set a dish by given dish id.
    @dish = Dish.dish_by_id(params[:id])
  end
  
  # POST /postdish
  #Create a new dish, using a dish model inicialised in /dish/New.
  def create
    
    #Create a new dish matching properties ( not all properties.)
    @dish = Dish.new(params[:dish])
    
    #Set the dish type querying the database.
    @dish.dishtype = Dishtype.find_by_id(params[:dishtype][:id])
    
    #Create a nested user attached to the dish
    @dish.nesteduser = @current_user.to_nested
    
    #Store the image in a safely way.
    @dish.store_image(params[:picture])
    
    #If the user is save correctly, redirect it the the account page on /Account.
    respond_to do |format|
      if @dish.save
        format.html { redirect_to account_page_path, notice: 'Dish was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end


  def edit
    @dish = Dish.dish_by_id(params[:id])
  end


  # PUT /updateaccount/
  def update
    @dish = Dish.dish_by_id(params[:id])

    respond_to do |format|
      if @dish.update_attributes(params[:dish])
        format.html { redirect_to @dish, notice: 'Dish was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dishes/1
  # DELETE /dishes/1.json
  def destroy
    @dish = Dish.find(params[:id])
    @dish.destroy

    respond_to do |format|
      format.html { redirect_to my_page_path }
      format.json { head :no_content }
    end
  end
end
