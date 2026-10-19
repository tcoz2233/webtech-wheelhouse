Rails.application.routes.draw do
  root "repairs#index"

  resources :customers
  resources :bikes
  resources :services
  resources :mechanics 
  resources :repairs do
    resources :photos, only: [:destroy], module: :repairs
  end

  namespace :api do
    namespace :v1 do
      resources :services, only: [:index, :show, :create]
      resources :repairs, only: [:index, :show]
    end
  end
end