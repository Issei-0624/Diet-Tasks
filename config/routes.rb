Rails.application.routes.draw do
  root to: 'users#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  post '/diettasks/:id/done' => 'diettasks#done',   as: 'done'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
     member do
      get :followings
      get :followers
      get :likes
    end
  end
  
  resources :diettasks
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  
end
