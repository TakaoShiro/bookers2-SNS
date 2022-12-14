Rails.application.routes.draw do
  get 'rooms/show'
  get 'searches/search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  devise_for :users
  get "home/about"=>"homes#about"
  get "search" => "searches#search"

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
  #いいね機能のルーティング
  resource :favorites, only: [:create, :destroy]
  #コメント機能のルーティング
  resources :book_comments, only: [:create, :destroy]
  end
 
 #DM機能のルーティング
 resources :users, only: [:index,:edit,:update]
 resources :messages, only: [:create]
 resources :rooms, only: [:create,:show]
 
  resources :users, only: [:index, :show, :edit, :update] do
  #フォロー機能のルーティング
   resource :relationships, only: [:create, :destroy]
   get 'followings' => 'relationships#followings', as: 'followings'
   get 'followers' => 'relationships#followers', as: 'followers'
  
    member do
      get :following, :followers
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end