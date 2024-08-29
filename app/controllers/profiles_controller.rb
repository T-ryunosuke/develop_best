class ProfilesController < ApplicationController
  before_action :set_user
  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: t("profiles.update.success")
    else
      flash.now[:info] = t("profiles.update.failure")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :name, :profile, :gender, :age, :avatar, :avatar_cache)
  end
end
