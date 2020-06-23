Rails.application.routes.draw do
  devise_for :users, 
  controllers: { registrations: :registrations }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'hello/index' => 'hello#index'
  get 'hello/link' => 'hello#link'
  get 'tweets' => 'tweets#index'
  get 'tweets/new' => 'tweets#new'
  get 'search/search' => 'search#search'

  post 'tweets' => 'tweets#create'
  
  get 'tweets/:id' => 'tweets#show',as: 'tweet'
  patch 'tweets/:id' => 'tweets#update'
  delete 'tweets/:id' => 'tweets#destroy'
  get 'tweets/:id/edit' => 'tweets#edit', as:'edit_tweet'
  get 'users/:id' => 'users#show'
  patch 'users/:id' => 'users#update'
  get 'users/:id/edit' => 'users#edit', as:'user_tweet'

  resources :tweets do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end

  resources :users, only: [:show, :edit, :update]

end
