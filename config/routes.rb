Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
  end

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show destroy] do
      resources :comments, only: %i[create destroy]
      get 'like' => 'likes#create', as: :likes
    end
  end

  resources :posts, only: %i[new create]

  namespace :api do
    namespace :v1 do
      post 'login' => 'authentication#login'
      get 'users/:id/posts' => 'posts#index'
      get 'posts/:id/comments' => 'comments#index'
      post 'posts/:id/comments' => 'comments#create'
      get 'users/:user_id/posts/:post_id/comments' => 'comments#index'
      post 'users/:user_id/posts/:post_id/comments' => 'comments#create'
    end
  end

  root 'users#index'
  get 'up' => 'rails/health#show', as: :rails_health_check
end
