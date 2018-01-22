class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] ="您已將#{User.find_by(id: params[:friend_id]).name}視為好友!"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end  
  end

  def destroy
    @friendship = current_user.friendship.where(friend_id: params[:id])
    @friendship.destroy_all
    flash[:alert] = "已不再將#{User.find_by(id: params[:id]).name}視為好友!"
    redirect_back(fallback_location: root_path)
  end

end
