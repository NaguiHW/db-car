class CarsController < ApplicationController
  def index
    cars = Car.all

    if !cars.empty?
      render json: {
        cars: cars
      }, status: 200
    else
      render json: {
        error: "Something went wrong."
      }
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
        error: "Something went wrong. Please try again."
      }
    end
  end

  def update
    car = Car.find(params[:id])

    if car.update(car_params)
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
    car = Car.find(params[:id])

    if car.destroy
      render json:  {
        message: "Car was successfully deleted."
      }, status: 200
    else
      render json: {
        error: "Something went wrong. Please try again."
      }
    end
  end

  def show
    car = Car.where(id: params[:id])

    if !car.empty?
      render json: {
        car: car
      }, status: 200
    else
      render json: {
        error: "Couldn't find the car."
      }
    end
  end

  def filterBy
    car = Car.where(carType: params[:type])

    if !car.empty?
      render json: {
        car: car
      }, status: 200
    else
      render json: {
        error: "Something went wrong."
      }
    end
  end
  
  private

  def car_params
    params.require(:car).permit(:model, :carType, :price, :year, :horsePower, :seats, :doors, :transmission, :quantity, :imagesLink)
  end
end
