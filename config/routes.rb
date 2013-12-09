Sidewalks::Application.routes.draw do

  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
  match '/welcome' => 'home#welcome'

  resources :noises, :only => [:index, :show]
  resources :users, :only => [:edit, :update]

  namespace :admin do
    resources :locations, :users
    resources :noises do
      resources :origins
    end
  end

  root :to => "noises#index"
end
