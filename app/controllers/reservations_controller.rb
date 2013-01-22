class ReservationsController < ApplicationController
  before_filter :require_login
  
  #Reserva a dish, post action on /reserve from dish/show.
  def reserve
    buyerid = @current_user._id

    # three parameters : date, hour and a dish id.
    respond_to do |format|
      #Process reservation with three parameters.
      if Reservation.Reserve(params[:date], params[:hour], params[:dishId], buyerid)
        format.html { redirect_to account_page_path, notice: 'Reservation done! Check out reservation category.' }
      else
        flash[:error] = "A Problem came while updating the reservation"
        redirect_to dish_show_page_path(params[:dishId]) # halts request cycle
      end
    end
  end

  #Change the state of the reservation to declined by the seller.
  def decline
    respond_to do |format|
      if Reservation.Decline(params[:id])
        format.html { redirect_to account_page_path, notice: 'Reservation declined!' }
      else
        flash[:error] = "A Problem came while updating the reservation"
        redirect_to account_page_path # halts request cycle
      end
    end
  end

  # Change the state of the reservation to canceled by the buyer
  def cancel
    respond_to do |format|
      if Reservation.Cancel(params[:id])
        format.html { redirect_to account_page_path, notice: 'Reservation canceled!' }
      else
        flash[:error] = "A Problem came while updating the reservation"
        redirect_to account_page_path # halts request cycle
      end
    end
  end

  # Change the state of the reservation to Reconsidered by the seller
  def reconsider
    respond_to do |format|
      if Reservation.Reconsider(params[:id])
        format.html { redirect_to account_page_path, notice: 'Reservation reconsidered!' }
      else
        flash[:error] = "A Problem came while updating the reservation"
        redirect_to account_page_path # halts request cycle
      end
    end
  end

  # Change the state of the reservation to Approved by the seller, ready to be checked out by the buyer.
  def approve
    respond_to do |format|
      if Reservation.Approve(params[:id])
        format.html { redirect_to account_page_path, notice: 'Reservation Approved!' }
      else
        flash[:error] = "A Problem came while updating the reservation"
        redirect_to account_page_path # halts request cycle
      end
    end
  end
  
  # Feature no implemented.
  def checkout
    
  end
end
