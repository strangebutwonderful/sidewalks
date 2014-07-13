Sidewalks::Application.routes.draw do

  match '/auth/:provider/callback' => 'sessions#create', via: :post
  match '/signin' => 'sessions#new', :as => :signin, via: :get
  match '/signout' => 'sessions#destroy', :as => :signout, via: [ :get, :post ]
  match '/auth/failure' => 'sessions#failure', via: :get
  match '/welcome' => 'home#welcome', via: :get

  match '/explore' => 'noises#explore', via: [ :get, :post ]

  resources :noises, :only => [ :index, :show ]
  resources :users, :only => [ :show, :edit, :update ]
  resources :search, :only => [ :index ]

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
