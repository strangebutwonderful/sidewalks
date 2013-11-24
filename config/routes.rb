Sidewalks::Application.routes.draw do

  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
  match '/welcome' => 'home#welcome'

  namespace :admin do
    resources :locations
    resources :users
  end

  resources :noises do 
    collection do 
      get 'import'
    end
  end

  resources :users, :only => [:index, :show, :edit, :update]

  root :to => "noises#index"
end
