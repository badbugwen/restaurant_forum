Rails.application.routes.draw do
  # use devise gem for user login
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show, :edit, :update] do

    #show user's all friends and inviters
    member do
      get :friend_list
    end  
  end  

  # user僅開放觀看 index & show for restaurant
  resources :restaurants, only: [:index, :show] do
    # 在restaurant下可Create and Destroy comments
    # POST restaurants/restaurant_id/comments
    # DELETE restaurants/restaurant_id/comments/:id
    resources :comments, only: [:create, :destroy]

    # 瀏覽所有餐廳的最新動態/前10熱門餐廳
    collection do
      get :feeds
      get :ranking
    end
  
    member do
      # 瀏覽個別餐廳的 Dashboard
      # GET restaurants/:id/dashboard
      get :dashboard

      # 加入最愛/取消最愛個別餐廳
      post :favorite
      post :unfavorite

      # 對個別餐廳按讚/收回讚
      post :like
      post :unlike
    end  
  end

  # user可 建立/刪除 追蹤其他user
  resources :followships, only: [:create, :destroy]

   # user可 建立/刪除 將其他user視為好友
  resources :friendships, only: [:create, :destroy]

  # 一般使用者僅開放Read for category
  resources :categories, only: [:show]
  root "restaurants#index"
  
  # admin開放CRUD for category
  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end
end