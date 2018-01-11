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

  def ranking
    @top_restaurants = Restaurant.order(favorites_count: :desc).limit(10)
    @categories = Category.all
  end
  
   # POST /restaurants/:id/favorite
  def favorite
    if Favorite.where(restaurant: @restaurant, user: current_user).count < 1 # 若user未曾收藏過此餐廳
      @restaurant.favorites.create!(user: current_user)
    else
      flash[:alert] = "You ALREADY favorited this restaurant!"  
    end  
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
    if Like.where(restaurant: @restaurant, user: current_user).count < 1 # 若user未曾like過此餐廳
      @restaurant.likes.create!(user_id: current_user.id)
    else
      flash[:alert] = "You ALREADY liked this restaurant!" 
    end   
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

