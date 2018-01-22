class UsersController < ApplicationController
  before_action :set_user, except:[:index]

  def index
    @users = User.order(name: :asc)
  end

  def show   
    @commented_restaurants = @user.restaurants
  end

  def update
    if @user == current_user
      # only userself can update profile in right format
      if @user.update(user_params)
        redirect_to user_path(params[:id])
        flash[:notice] = "User's profile was successfully updated"
      else
        flash.now[:alert] = "User's profile was failed to update"
        render :edit
      end
    else
        flash[:alert] = "You can not edit other user's profile!"
        redirect_to user_path(params[:id])
    end    
  end

  def friend_list

  end


  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
    params.require(:user).permit(:name, :intro, :avatar)
    end

end
