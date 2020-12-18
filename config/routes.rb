Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :registrations, only: [:create]
  resources :sessions,      only: [:create]
  resources :cars,          only: [:index, :create, :show, :update, :destroy]
  resources :reservations,  only: [:index, :create]
  delete :logout,           to: "sessions#logout"
  get    :logged_in,        to: "sessions#logged_in"
  get    'filterBy/:type',  to: "cars#filterBy"
  get    'allReservations', to: "reservations#showAll"
end
