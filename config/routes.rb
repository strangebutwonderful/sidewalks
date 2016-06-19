Sidewalks::Application.routes.draw do
  namespace :admin do
    resources :config, only: [:index]
    resources :errors, only: [:index]
    resources :locations
    resources :noises, except: [:new, :create] do
      collection do
        get "triage"
      end

      resources :origins
    end
    resources :users, except: [:destroy] do
      collection do
        get "triage"
      end
    end
  end

  match "/auth/:provider/callback", to: 'sessions#create', via: [:get, :post]
  match "/signin", to: 'sessions#new', as: :signin, via: [:get, :post]
  match "/signout", to: 'sessions#destroy', as: :signout, via: [:get, :post]
  match "/auth/failure", to: 'sessions#failure', via: :get
  match "/welcome", to: 'home#welcome', via: :get

  match "/explore", to: 'noises#explore', via: [:get, :post]

  resources :noises, only: [:index, :show]
  resources :users, only: [:show, :edit, :update]
  resources :search, only: [:index]

  root to: 'home#welcome'
end
