Rails.application.routes.draw do
  root 'sessions#new'

  # resources :favorites, only: [:index, :create, :destroy]
  resources :favorites
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:show, :new, :create, :edit, :update]

  resources :posts do
    collection do
      post :confirm
    end
  end

end
