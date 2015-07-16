PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :posts do
    resources :comments, only: [:create] do
      post 'vote', on: :member
    end
    post 'vote', on: :member
  end

  resources :categories, only: [:create, :new, :show]
  get 'register', to: 'users#new'
  resources :users, only: [:edit, :create, :show, :update]

  get '/log_in', to: 'sessions#new', as: 'login'
  post '/log_in', to: 'sessions#create'
  post '/log_out', to: 'sessions#destroy', as: 'logout'
end
