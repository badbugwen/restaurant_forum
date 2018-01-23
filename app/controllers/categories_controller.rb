class CategoriesController < ApplicationController
  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @restaurants = @category.restaurants.includes(:favorited_users).page(params[:page]).per(9)
  end
end
