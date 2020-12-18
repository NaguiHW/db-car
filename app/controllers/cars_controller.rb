class CarsController < ApplicationController
  def index
    cars = Car.all
    # json_response(cars)

    if !cars.empty?
      render json: {
        cars: cars
      }
    else
      render json: {
        error: "Something went wrong."
      }, status: 404
    end
  end

  def create
    car = Car.create!(car_params)

    if car
      render json: {
        status: :created,
        car: car
      }, status: 201
    else
      render json: {
        status: 500,
        error: "Something went wrong. Please try again."
      }
    end
  end

  def update
    car = Car.find(params[:id])

    if car.update(car_params)
      render json:  {
        status: 200,
        message: "Updated successfully."
      }
    else
      render json: {
        status: 500,
        error: "Something went wrong. Please try again."
      }
    end
  end

  private

  def car_params
    params.require(:car).permit(:model, :carType, :price, :year, :horsePower, :seats, :doors, :transmission, :quantity, :imagesLink)
  end
end
