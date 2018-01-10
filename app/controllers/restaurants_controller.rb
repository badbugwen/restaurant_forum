class RestaurantsController < ApplicationController
  before_action :set_restaurant, only:[:show, :dashboard, :favorite, :unfavorite, :like, :unlike]

  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
    @categories = Category.all
  end
  
  def show
    @comment = Comment.new
  end

  def feeds
    @recent_restaurants = Restaurant.order(created_at: :desc).limit(10)
    @recent_comments = Comment.order(created_at: :desc).limit(10)
    @categories = Category.all
  end

  def dashboard
  end
  
   # POST /restaurants/:id/favorite
  def favorite
    @restaurant.favorites.create!(user: current_user)
    # 導回上一頁，若找不到上一頁則回首頁
    redirect_back(fallback_location: root_path)
  end

  # POST /restaurants/:id/unfavorite
  def unfavorite
    favorite = Favorite.where(restaurant: @restaurant, user: current_user)
    favorite.destroy_all
    redirect_back(fallback_location: root_path)
  end  

  def like
    @restaurant.likes.create!(user_id: current_user.id)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    like = Like.where(restaurant: @restaurant, user: current_user).first
    like.destroy
    redirect_back(fallback_location: root_path)
  end

  ###################
  private
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

end

