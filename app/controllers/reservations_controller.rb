class ReservationsController < ApplicationController
  include CurrentUserConcern

  def index
    reservations =  Reservation.where(user_id: @current_user.id)

    if !reservations.empty?
      render json: {
        reservations: reservations
      }, status: 200
    else
      render json: {
        error: "We couldn't find a reservation or you don't have a reservation."
      }, status: 404
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
      }, status: 500
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
      }, status: 401
    else
      render json: {
        error: "Something went wrong. Please try again."
      }, status: 500
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:user_id, :car_id, :startDate, :endDate, :total)
  end
end
