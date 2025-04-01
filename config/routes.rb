Rails.application.routes.draw do 
  # Homepage
  root "pages#home"

  # Static pages
  get "/about", to: "pages#about"
  get "/donate", to: "payments#new"
  get "/cgu", to: "pages#cgu"

  # Devise authentication
  devise_for :users, controllers: { sessions: 'users/sessions' }

  # ✅ Correction du problème Devise avec devise_scope
  devise_scope :user do
    get 'signup', to: 'devise/registrations#new', as: :signup
    get 'login', to: 'devise/sessions#new', as: :login
    get 'password/new', to: 'devise/passwords#new', as: :new_password
  end

  # Users
  resources :users, only: [:index, :edit, :update, :destroy, :show]

  # Members page
  resources :members, only: [:index, :show]

  # Events
  get "/events", to: "pages#events"
  resources :events do
    member do
      patch "toggle_participation"
    end
  end

  # Pictures
  resources :pictures, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  # Admin namespace
  namespace :admin do
    root to: "dashboard#index"

    resources :users do
      member do
        put "update_role", to: "users#update_role"
        delete "force_delete", to: "users#force_delete"
      end
    end

    resources :events
  end

  # Payment process with Stripe
  resources :checkout, only: [:create] do
    collection do
      get 'success'
      get 'cancel'
    end
  end

  # Application health check
  get "up" => "rails/health#show", as: :rails_health_check

  get 'weather', to: 'weather#show'

  # Contact form ✅ Correction ici !
  resources :contacts, only: [:new, :create]
end