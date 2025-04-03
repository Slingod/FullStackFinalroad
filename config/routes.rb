Rails.application.routes.draw do
  # Page d'accueil
  root 'pages#home'

  # Pages statiques
  get '/about', to: 'pages#about'
  get '/donate', to: 'payments#new'
  get '/cgu', to: 'pages#cgu'

  # Routes pour les utilisateurs avec Devise
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  # Gestion des utilisateurs
  resources :users, only: [:index, :show, :edit, :update, :destroy]

  # Espace Admin
  namespace :admin do
    root 'dashboard#index'  # Correction admin_root_path
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :events  # Inclut new, create, edit, update, show, destroy
  end

  # Routes pour les événements publics
  resources :events do
    patch 'toggle_participation', on: :member
  end

  # Autres fonctionnalités
  get '/weather', to: 'weather#show'
  resources :contacts, only: [:new, :create]
end