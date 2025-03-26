Rails.application.routes.draw do 
  # Homepage
  root "pages#home"

  # Static pages
  get "/about", to: "pages#about"
  get "/contact", to: "contacts#new"
  post "/contact", to: "contacts#create"

  # Devise for authentication
  devise_for :users, controllers: { sessions: 'users/sessions' }

  # Custom Devise routes for additional user actions
  devise_scope :user do
    get "signup", to: "devise/registrations#new", as: :signup
    get "login", to: "devise/sessions#new", as: :login
    get "password/new", to: "devise/passwords#new", as: :forgot_password
  end

  # User resource (for standard users)
  resources :users, only: [:show, :edit, :update, :destroy]

  # Members page
  resources :members, only: [:index, :show]

  # Nouvelle page Events
  get "/events", to: "pages#events"

  # Resources for events (y compris participation)
  resources :events do
    member do
      post "toggle_participation"
    end
  end

  # Resources for pictures
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

  # Payment process with Stripe (checkout actions)
  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  # Donation page
  get "/donate", to: "payments#new"

  # CGU page
  get "/cgu", to: "pages#cgu"

  # Application health check route
  get "up" => "rails/health#show", as: :rails_health_check

  get 'weather', to: 'weather#show'

  # Contact form
  resources :contacts, only: [:new, :create]
end