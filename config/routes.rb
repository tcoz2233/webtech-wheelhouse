Rails.application.routes.draw do
  root "bikes#index"

  resources :customers
  resources :bikes
  resources :repairs
  resources :mechanics
  resources :services
end