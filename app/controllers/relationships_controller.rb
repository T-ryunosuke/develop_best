class RelationshipsController < ApplicationController
  # フォローするとき
  def create
    @user = User.find(params[:user_id])

    @user.with_lock do
      unless current_user.followee?(@user) # すでにフォローしていないか確認
        current_user.follow(@user.id)
        @user.create_notification_follow!(current_user)
      end
    end

    redirect_to request.referer
  end


  # フォロー外すとき
  def destroy
    @user = User.find(params[:user_id])

    @user.with_lock do
      relationship = current_user.relationships.find_by(followee_id: @user.id)
      relationship&.destroy # 存在すれば削除する
    end

    redirect_to request.referer
  end
end
