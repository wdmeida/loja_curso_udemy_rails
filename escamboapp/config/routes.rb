Rails.application.routes.draw do

  require "sidekiq/web"
  mount Sidekiq::Web => '/sidekiq'

  post '/rate' => 'rater#create', :as => 'rate'
  root 'site/home#index'

  get 'backoffice', to: 'backoffice/dashboard#index'
  
  namespace :checkout do
    resources :payments, only: [:create]
    resources :notifications, only: [:create]
  end

  namespace :backoffice do
    resources :admins, except: [:show]  
    resources :categories, except: [:show, :destroy]
    resources :send_mail, only: [:edit, :create]
    resources :diagrams, only: [:index]
    get 'dashboard', to: 'dashboard#index'
  end

  namespace :site do
    get 'home', to: 'home#index'
    get 'search', to: 'search#ads'

    namespace :profile do
      resources :dashboard, only: [:index]
      resources :ads, only: [:index, :edit, :update, :new, :create]
      resources :my_data, only: [:edit, :update]  
    end

    resources :ad_details, only: [:index, :show]
    resources :categories, only: [:show] 
    resources :comments, only: [:create]
  end

  devise_for :admins, :skip => [:registrations]
  devise_for :members, controllers: { 
    sessions: 'members/sessions',
    registrations: 'members/registrations'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
