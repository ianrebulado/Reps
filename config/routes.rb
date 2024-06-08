Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Health check route
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Root route
  root 'home#home'

  # Custom home routes
  get 'profile', to: 'home#show'
  get 'programs', to: 'home#programs'
  get 'home', to: 'home#home'
  patch 'profile/update', to: 'home#update', as: :update_profile
  get 'edit', to: 'home#edit'
  get 'create_default_workout_and_redirect', to: 'home#create_default_workout_and_redirect'

  # Resourceful routes for workouts and nested resources for exercises
  resources :workouts do
    resources :exercises
  end
end
