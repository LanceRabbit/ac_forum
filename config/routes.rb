Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  
  # 前台
  resources :posts do
    resources :replies, only: [:create, :update, :destroy, :edit]
    # 收藏
    post :collect, :on => :member
    post :uncollect, :on => :member
  end

  resources :users, only: [:show, :update, :edit ] do
      get :replies, :on => :member
      get :collections, :on => :member
      get :drafts, :on => :member
      get :friends, :on => :member
  
  end

  resources :friendships, only: [:create, :destroy] do
    post :accept, :on => :member
  end

  resources :feeds, only: [:index]

  root "posts#index"
  
  #api
  namespace :api, defaults: {format: :json} do
    namespace :v1 do

      post "/login" => "auth#login"
      post "/logout" => "auth#logout"

      resources :posts, only:[:index, :show, :create, :update, :destroy]
    end
  end

  # 後台
  # url path for admin 
  # 避免被猜出後台位置, 可修改名稱用path 替換 admin
  # namespace :admin , path: "nobody123know" do
  namespace :admin, path: "nobody123know" do
    resources :users, :categories 
    root "users#index"
  end

  # 不存在的路徑都導向首頁
  get '*path', to: 'posts#index'
end
