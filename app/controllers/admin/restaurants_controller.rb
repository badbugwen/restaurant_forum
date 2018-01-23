class Admin::RestaurantsController < Admin::BaseController
before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    @restaurants = Restaurant.page(params[:page]).per(10)
    @categories = Category.order(created_at: :desc)
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to admin_restaurants_path, notice: "Restaurant was successfully created"
    else
      render :new, alert: "Restaurant was dailed to create"
    end  
  end
 
  def update
    if @restaurant.update(restaurant_params)
      redirect_to admin_restaurants_path(@restaurant), notice: "Restaurant was successfully updated"
    else
      render :edit, alert: "Restaurant was failed to update"
    end  
  end 

  def destroy
    @restaurant.destroy
    redirect_to admin_restaurants_path, alert: "餐廳已刪除"
  end 
    
private  

  def restaurant_params
    params.require(:restaurant).permit(:name, :opening_hours, :tel, :address, :descrition, :image, :category_id ) 
  end  

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end  

end

