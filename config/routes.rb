Sidewalks::Application.routes.draw do

  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
  match '/welcome' => 'home#welcome'

  resources :noises
  resources :users, :only => [:index, :show, :edit, :update]

  namespace :admin do
    resources :locations, :noises, :users
  end

  root :to => "noises#index"
end
