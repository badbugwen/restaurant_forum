class UsersController < ApplicationController
  before_action :set_user

  def show   
  end


  def update
    if @user == current_user
      @user.update(user_params)
      redirect_to user_path(params[:id])
      flash[:notice] = "User's profile was successfully updated"
    else
      flash.now[:alert] = "User's profile was failed to update"
      render :edit
    end
  end




  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
    params.require(:user).permit(:name, :intro, :avatar)
    end

end
