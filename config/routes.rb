Rails.application.routes.draw do
  root 'users#index'
  resource :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end
end
