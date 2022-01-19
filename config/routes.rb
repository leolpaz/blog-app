Rails.application.routes.draw do
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
    end
  end
  resources :posts, only: [:show] do
    resources :comments, only: [:new, :create]
  end
end
