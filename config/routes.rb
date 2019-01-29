Rails.application.routes.draw do
  #API namespace
  namespace :api do
    namespace :v1 do
      resources :posts, only: :create do
        get :top, on: :collection
      end
      resources :rates, only: :create
      resources :ips, only: :index
    end
  end
end
