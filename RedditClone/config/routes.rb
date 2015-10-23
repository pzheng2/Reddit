Rails.application.routes.draw do

  resources :users, only:   [:new, :create, :show]
  resources :posts, except: [:new, :index]
  resource :session, only:  [:new, :destroy, :create]

  resources :subs, except:  [:destroy] do
    resources :posts, only: [:new]
  end

end
