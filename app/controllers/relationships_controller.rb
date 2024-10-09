class RelationshipsController < ApplicationController
  # フォローするとき
  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user.id)
    @user.create_notification_follow!(current_user)
    redirect_to request.referer
  end
  # フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
end
