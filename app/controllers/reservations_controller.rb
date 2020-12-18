class ReservationsController < ApplicationController
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

  private

  def reservation_params
    params.require(:reservation).permit(:user_id, :car_id, :startDate, :endDate, :total)
  end
end
