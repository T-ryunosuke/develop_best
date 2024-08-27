class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, success: t("users.create.success")
    else
      flash.now[:info] = t("users.create.failure")
      render :new, status: :unprocessable_entity
    end
  end

  def liked_posts
    @posts = current_user.liked_posts.includes(:category).order(created_at: :desc).page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :gender, :profile, :avatar, :avatar_cache)
  end
end
