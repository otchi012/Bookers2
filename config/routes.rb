Rails.application.routes.draw do
  get 'chats/show'
  root 'homes#top'
  get 'home/about' => 'homes#about'
  get 'search' => 'searchs#search'
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  resources :users, only: [:index, :show, :edit, :update]do
    member do
      get :following, :followers
    end
  # post 'relationship/:id' => 'relationships#create', as: 'relationship'
  # delete 'relationship/:id' => 'relationships#destroy', as: 'destroy_relationship'
    resource :relationships, only: [:create, :destroy]
  end
  # resources :rooms, only: [:index, :create, :show]
  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
