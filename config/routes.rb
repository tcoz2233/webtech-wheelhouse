Rails.application.routes.draw do
  root "repairs#index"

  resources :customers
  resources :bikes
  resources :services
  resources :mechanics 
  resources :repairs
end