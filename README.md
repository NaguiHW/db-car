# Rent a Car Database

This is the backend for the project [Rent a Car](https://github.com/NaguiHW/rent-a-car).

## Clone Project
Copy this code in your terminal:
```
git clone git@github.com:NaguiHW/db-car.git
```

## Install Project
Now you have to enter in the project:
```
cd db-car
```
Install all gems and dependencies
```
bundle i
```
```
yarn install
```

## Create the database
Because this project use `postgresql` for the backend, we have to create the database, before the migrations.
```
rails db:create
```
```
rails db:migrate
```

## Start Local Server
```
rails s
```
The server is going to be in `http://localhost:8000/`

## Endpoints (live server)
The route of the live server is: `https://serene-bayou-97137.herokuapp.com/`
- `/registrations`: to create a new user.
  - `POST`: body => user: { first_name, last_name, email, password, password_confirmation }
- `/sessions`: to login of an existing user.
  - `POST`: body => user: { email, password }
- `/logged_in`: verify if an user is logged in or not
  - `GET`
- `/logout`: expire the session.
  - `DELETE`
- `/cars`: CRUD cars.
  - `GET`: return all cars in the database
  - `POST`: body => car: { model, carType, price, year, horsePower, seats, doors, transmission, quantity, imagesLink }
  - `/:id`
    - `GET`: return car info depending of the gived `:id`.
    - `PUT`: body => car: { model, carType, price, year, horsePower, seats, doors, transmission, quantity, imagesLink }
    - `DELETE`: delete the car wih the id `:id`.
- `/filterBy/:type`: show cars depending of the gived `:type`.
- `/reservations`: CRUD reservations.
  - `GET`: return the reservations of the current user.
  - `POST`: body => reservation: { user_id, car_id, startDate, endDate, total }
    - `/:id`
      - `PUT`: body => reservation: { user_id, car_id, startDate, endDate, total }
      - `DELETE`: delete the reservation with the id `:id`/
- `/allReservations`: show all reservations.