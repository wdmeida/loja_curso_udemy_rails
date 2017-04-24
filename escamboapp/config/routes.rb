Rails.application.routes.draw do

  root 'site/home#index'

  get 'backoffice', to: 'backoffice/dashboard#index'
  
  namespace :backoffice do
    # Cria os recursos para categorias, exceto para show.
    resources :categories, except: [:show, :destroy]
    resources :admins, except: [:show]
    get 'dashboard', to: 'dashboard#index'
  end

  namespace :site do
    get 'home', to: 'home#index'
  end

  devise_for :admins, :skip => [:registrations]
  devise_for :members

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
