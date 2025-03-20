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
    get "signup", to: "devise/registrations#new", as: :signup # Registration page
    get "login", to: "devise/sessions#new", as: :login        # Login page
    get "password/new", to: "devise/passwords#new", as: :forgot_password # Forgot password page
  end

  # User resource (for standard users)
  resources :users, only: [:show, :edit, :update, :destroy]

  # Members page
  resources :members, only: [:index, :show]

  # Resources for events (including member actions)
  resources :events do
    member do
      post "register"   # Register for an event
      delete "unregister" # Unregister from an event
    end
  end

  # Resources for pictures
  resources :pictures, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  # Shop page
  get "shop", to: "home#shop", as: :shop

  # Admin namespace
  namespace :admin do
    # Dashboard as the root for admin namespace
    root to: "dashboard#index"

    # Admin-specific user management
    resources :users do
      member do
        put "update_role", to: "users#update_role"      # Route to modify user roles (permissions)
        delete "force_delete", to: "users#force_delete" # Super Admin can delete another admin
      end
    end

    # Admin-specific events management
    resources :events
  end

  # Payment process with Stripe (checkout actions)
  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'   # Create checkout session
    get 'success', to: 'checkout#success', as: 'checkout_success' # On successful payment
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'    # On cancelled payment
  end

  # Donation page
  get "/donate", to: "payments#new"

  # CGU page
  get "/cgu", to: "pages#cgu"

  # Application health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Contact form
  resources :contacts, only: [:new, :create]
end