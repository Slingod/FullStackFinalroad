Rails.application.routes.draw do
  root "pages#home"

  get "/about", to: "pages#about"
  get "/contact", to: "pages#contact"

  devise_for :users

  resources :users, only: [:show]
  resources :events do
    member do
      post "register"
      delete "unregister"
    end
  end

  namespace :admin do
    get "dashboard", to: "dashboard#index"
  end

  get "/donate", to: "payments#new"

  get "up" => "rails/health#show", as: :rails_health_check
end