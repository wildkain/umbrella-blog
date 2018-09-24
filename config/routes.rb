Rails.application.routes.draw do
  #API namespace
  namespace :api do
    namespace :v1 do
      resources :posts, only: :create do
      end
      resources :rates, only: :create
    end
  end
end
