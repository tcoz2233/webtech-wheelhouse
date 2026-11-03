Rails.application.routes.draw do
  resource :session
  resource :registration, only: [:new, :create]
  resources :passwords, param: :token

  resources :services
  resources :repairs do
    resources :photos, only: :destroy, controller: "repairs/photos"
  end
  resources :customers
  resources :bikes
  resources :mechanics, only: [:index, :show]

  namespace :api do
    namespace :v1 do
      resources :services, only: [:index, :show]
      resources :repairs, only: [:index, :show]
    end
  end

  root "repairs#index"
end