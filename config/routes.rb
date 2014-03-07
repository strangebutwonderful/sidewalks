Sidewalks::Application.routes.draw do

  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
  match '/welcome' => 'home#welcome'

  resources :noises, :only => [:index, :show]
  resources :users, :only => [:show, :edit, :update]
  resources :search, :only => [:index]

  namespace :admin do
    resources :config
    resources :errors
    resources :locations
    resources :noises do
      collection do 
        get 'triage'
      end
      
      resources :origins
    end
    resources :users do
      collection do 
        get 'triage'
      end
    end
  end

  root :to => "noises#index"
end
