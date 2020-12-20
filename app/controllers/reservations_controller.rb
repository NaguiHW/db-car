class ReservationsController < ApplicationController
  include CurrentUserConcern

  def index
    reservations =  Reservation.where(user_id: @current_user.id).find_by_sql("SELECT r.*, c.model, c.image1 FROM reservations r INNER JOIN cars c ON r.car_id = c.id")

    if !reservations.empty?
      render json: {
        reservations: reservations
      }, status: 200
    else
      render json: {
        error: "We couldn't find a reservation or you don't have a reservation."
      }
    end
  end
  
  def create
    reservation = Reservation.create!(reservation_params)

    if reservation
      render json: {
        message: "Your reservation was created successfully.",
        reservation: reservation
      }, status: 200
    else
      render json: {
        error: "Something went wrong. Please try again."
      }
    end
  end

  def showAll
    reservations = Reservation.all

    if @current_user.admin and !reservations.empty?
      render json: {
        reservations: reservations
      }, status: 200
    elsif @current_user.admin and reservations.empty?
      render json: {
        message: "Right now, we don't have any reservations."
      }, status: 200
    elsif !@current_user.admin
      render json: {
        error: "You don't have permission to see this."
      }
    else
      render json: {
        error: "Something went wrong. Please try again."
      }
    end
  end

  def update
    reservation = Reservation.find(params[:id])

    if reservation.update(reservation_params)
      render json:  {
        message: "Updated successfully."
      }, status: 200
    else
      render json: {
        error: "Something went wrong. Please try again."
      }
    end
  end

  def destroy
    reservation = Reservation.find(params[:id])

    if reservation.destroy
      render json:  {
        message: "Reservation was successfully deleted."
      }, status: 200
    else
      render json: {
        error: "Something went wrong. Please try again."
      }
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:user_id, :car_id, :startDate, :endDate, :total)
  end
end
