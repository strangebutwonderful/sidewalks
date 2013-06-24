Sidewalks::Application.routes.draw do
  
  match '/tweets/import'  => 'tweets#import'
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
  match '/welcome' => 'home#welcome'

  resources :tweets
  resources :users, :only => [:index, :show, :edit, :update ]

  root :to => "tweets#index"
end
