Rails.application.routes.draw do
  resources :signups, only: [:create]
  resources :activities, except: [:create, :update, :show]
  resources :campers, only: [:show, :create, :index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
