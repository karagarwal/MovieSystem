Rails.application.routes.draw do
  resources :theaters
  resources :showtimes
  resources :seat_types
  resources :tickets
  resources :users
  resources :movies
  resources :audis
end
