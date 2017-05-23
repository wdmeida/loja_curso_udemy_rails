Rails.application.routes.draw do

  root 'site/home#index'

  get 'backoffice', to: 'backoffice/dashboard#index'
  
  namespace :backoffice do
    resources :admins, except: [:show]  
    resources :categories, except: [:show, :destroy]
    resources :send_mail, only: [:edit, :create]
    get 'dashboard', to: 'dashboard#index'
  end

  namespace :site do
    get 'home', to: 'home#index'

    namespace :profile do
      resources :dashboard, only: [:index]
      resources :ads, only: [:index, :edit, :update, :new, :create]  
    end
  end

  devise_for :admins, :skip => [:registrations]
  devise_for :members

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
