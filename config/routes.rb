Rails.application.routes.draw do
  # Homepage
  root "pages#home"

  # Static pages
  get "/about", to: "pages#about"
  get "/contact", to: "contacts#new"
  post "/contact", to: "contacts#create"

  # Devise for authentication
  devise_for :users, controllers: { sessions: 'users/sessions' }

  devise_scope :user do
    get "signup", to: "devise/registrations#new", as: :signup
    get "login", to: "devise/sessions#new", as: :login
    get "password/new", to: "devise/passwords#new", as: :forgot_password
  end

  # User resource
  resources :users, only: [:show, :edit, :update, :destroy]

  # Resources for events
  resources :events do
    member do
      post "register"
      delete "unregister"
    end
  end

  # Resources for pictures
  resources :pictures, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  # Shop page
  get "shop", to: "home#shop", as: :shop

  # Admin space
  namespace :admin do
    root to: "dashboard#index"

    resources :users do
      member do
        put "update_role", to: "users#update_role" # To modify permissions
        delete "force_delete", to: "users#force_delete" # Super Admin can delete an admin
      end
    end

    resources :events
  end

  # Payment process with Stripe
  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  # Donation page
  get "/donate", to: "payments#new"

  # CGU page
  get "/cgu", to: "pages#cgu"

  # Application health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Contact form
  resources :contacts, only: [:new, :create]
end
