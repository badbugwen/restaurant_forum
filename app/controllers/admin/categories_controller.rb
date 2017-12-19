class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: [:update, :destroy]

  def index
    @categories = Category.all
    if params[:id]
      set_category
    else
      @category = Category.new 
    end  
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
      flash[:notice] = "New category was successfully created!"
    else 
      @categories = Category.all
      render :index
    end  
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path
      flash[:notice] = "Category was successfully updated!" 
    else 
      @categories = Category.all
      render :index
    end  
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path
    flash[:alert] = "分類已刪除"
  end 

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
  @category = Category.find(params[:id])
  end

end