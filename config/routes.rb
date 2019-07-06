Rails.application.routes.draw do
  root to: 'tasks#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]
  
  # resources :tasks, only: [:show, :new, :create, :edit, :update, :destroy]
  # 以下はtasks_pathのルーティングを閉じている
  resources :tasks, except: [:index]
end