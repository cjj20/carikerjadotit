Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"
  get "/", to: "home#index"
  get "/detail", to: "jobs#index"
  get "/articles", to: "articles#index"

  namespace :api do
    namespace :v1 do
      resources :jobs
    end
  end
end
