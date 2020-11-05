Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about' => 'homes#about'
  get 'search' => 'searchs#search'
  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]do
    member do
      get :following, :followers
    end
  # post 'relationship/:id' => 'relationships#create', as: 'relationship'
  # delete 'relationship/:id' => 'relationships#destroy', as: 'destroy_relationship'
    resource :relationships, only: [:create, :destroy]
  end
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
