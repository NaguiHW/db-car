class ReservationsController < ApplicationController
  include CurrentUserConcern

  def index
    past_reservations = Reservation.find_by_sql("SELECT r.*, c.model, c.image1
                                                 FROM reservations r
                                                 INNER JOIN cars c
                                                 ON r.car_id = c.id
                                                 WHERE r.user_id = #{@current_user.id}
                                                 AND r.endDate < '#{DateTime.now}'
                                                 ORDER BY r.end_date")

    current_reservations = Reservation.find_by_sql("SELECT r.*, c.model, c.image1
                                                    FROM reservations r
                                                    INNER JOIN cars c
                                                    ON r.car_id = c.id
                                                    WHERE r.user_id = #{@current_user.id}
                                                    AND r.endDate <= '#{DateTime.now}'
                                                    AND r.endDate >= '#{DateTime.now}'
                                                    ORDER BY r.end_date")

    future_reservations = Reservation.find_by_sql("SELECT r.*, c.model, c.image1
                                                   FROM reservations r
                                                   INNER JOIN cars c
                                                   ON r.car_id = c.id
                                                   WHERE r.user_id = #{@current_user.id}
                                                   AND r.endDate > '#{DateTime.now}'
                                                   ORDER BY r.end_date")

    if past_reservations.length + current_reservations.length + future_reservations.length == 0
      render json: {
        length: 0,
        message: "Yoy don't have any reservations."
      }
    elsif past_reservations.length + current_reservations.length + future_reservations.length > 0
      render json: {
        length: past_reservations.length + current_reservations.length + future_reservations.length,
        future_reservations: {
          length: future_reservations.length,
          reservations: future_reservations
        },
        past_reservations: {
          length: past_reservations.length,
          reservations: past_reservations
        },
        current_reservations: {
          length: current_reservations.length,
          reservations: current_reservations
        }
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
    past_reservations = Reservation.find_by_sql("SELECT r.*, c.model, c.image1, u.first_name, u.last_name
                                                 FROM reservations r
                                                 INNER JOIN cars c ON r.car_id = c.id
                                                 INNER JOIN users u ON r.user_id = u.id
                                                 WHERE r.end_date < '#{DateTime.now}'
                                                 ORDER BY r.end_date")
                                                 
    future_reservations = Reservation.find_by_sql("SELECT r.*, c.model, c.image1, u.first_name, u.last_name
                                                   FROM reservations r
                                                   INNER JOIN cars c ON r.car_id = c.id
                                                   INNER JOIN users u ON r.user_id = u.id
                                                   WHERE r.start_date > '#{DateTime.now}'
                                                   ORDER BY r.end_date")

    current_reservations = Reservation.find_by_sql("SELECT r.*, c.model, c.image1, u.first_name, u.last_name
                                                    FROM reservations r
                                                    INNER JOIN cars c ON r.car_id = c.id
                                                    INNER JOIN users u ON r.user_id = u.id
                                                    WHERE r.start_date <= '#{DateTime.now}'
                                                    AND r.end_date >= '#{DateTime.now}'
                                                    ORDER BY r.end_date")

    if @current_user.admin and (!past_reservations.empty? or !current_reservations.empty? or !future_reservations.empty?)
      render json: {
        length: past_reservations.length + current_reservations.length + future_reservations.length,
        future_reservations: {
          length: future_reservations.length,
          reservations: future_reservations
        },
        past_reservations: {
          length: past_reservations.length,
          reservations: past_reservations
        },
        current_reservations: {
          length: current_reservations.length,
          reservations: current_reservations
        }
      }, status: 200
    elsif @current_user.admin and reservations.empty? and current_reservations.empty? and future_reservations.empty?
      render json: {
        length: 0,
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
