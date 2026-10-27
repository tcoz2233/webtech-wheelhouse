Rails.application.routes.draw do
  resource :session
  resource :registration, only: [:new, :create]
  resources :passwords, param: :token

  resources :services
  resources :repairs
  resources :customers
  resources :bikes
  resources :mechanics

  namespace :api do
    namespace :v1 do
      resources :services, only: [:index, :show]
      resources :repairs, only: [:index, :show]
    end
  end

  root "repairs#index"
end