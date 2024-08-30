class UsersController < ApplicationController
  def index
    @users = User.order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
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

  # フォロイー一覧
  def followees
    user = User.find(params[:user_id])
    @users = user.followees
  end
  # フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :gender, :profile, :avatar, :avatar_cache)
  end
end
