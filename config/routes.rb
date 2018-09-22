Rails.application.routes.draw do
  #API namespace
  namespace :api do
    namespace :v1 do
      resources :posts, only: :create
    end
  end
end
