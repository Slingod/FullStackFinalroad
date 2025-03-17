Rails.application.routes.draw do
  # Home Page
  root "pages#home"

  # Page about and contact
  get "/about", to: "pages#about"
  get "/contact", to: "contacts#new", as: :contact
  post "/contact", to: "contacts#create"

  # Devise roads for users
  devise_for :users

  devise_scope :user do
    get "signup", to: "devise/registrations#new", as: :signup
    get "login", to: "devise/sessions#new", as: :login
  end

  # User profile
  resources :users, only: [:show]

  # registration or unregistration to an event
  resources :events do
    member do
      post "register"
      delete "unregister"
    end
  end

  # Picture
  resources :pictures, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  # Page Shop
  get "shop", to: "home#shop", as: :shop

  # Admin space
  namespace :admin do
    root to: "dashboard#index"
    resources :users
  end

  # Processus for payment
  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  # Page for donations
  get "/donate", to: "payments#new"

  get "up" => "rails/health#show", as: :rails_health_check
end