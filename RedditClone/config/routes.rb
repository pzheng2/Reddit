Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resources :subs, except: [:destroy]
  resource :session, only: [:new, :destroy, :create]
end
