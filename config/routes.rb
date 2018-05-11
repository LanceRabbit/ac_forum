Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  
  # 前台
  resources :posts do
    resources :replies, only: [:create, :index, :show]
  end

  resources :users

  root "posts#index"

  # 後台
  # url path for admin 
  # 避免被猜出後台位置, 可修改名稱用path 替換 admin
  # namespace :admin , path: "nobody123know" do
  namespace :admin, path: "nobody123know" do
    resources :users, :categories 
    root "users#index"
  end
  
end
