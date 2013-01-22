class SessionsController < ApplicationController
  # Register page, New user instanciated.
  def new
    @user = User.new
  end

  #Post of the /new page.
  def register
    # User inicialized with entry params.
    @user = User.new(params[:user])

    # if the user is succesfully saved, authenticate it, and redirect back to /Account.
    respond_to do |format|
      if @user.save
        user = User.authenticate(@user.email, @user.password)
        if user
          format.html { redirect_to account_page_path, notice: 'Account successfully created' }
          session[:user_id] = user.id
        end
        format.html { redirect_to root_path }
      else
        format.html { render action: "new" }
      end
    end
  end

# Log page, doesn't need to have a model.
  def log
  end

#User log in post.
  def create
    # Authenticate the user.
    user = User.authenticate(params[:email], params[:password])
    
    #If user if valid, affect session, and redirect back to
    if user
      session[:user_id] = user.id
      redirect_to account_page_path, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  # Log out flushing session record.
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
