Rails.application.routes.draw do
  root 'sessions#new'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  resources :favorites, only: [:index, :create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:show, :new, :create, :edit, :update]

  resources :posts do
    collection do
      post :confirm
    end
  end

end
