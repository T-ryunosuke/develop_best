class UsersController < ApplicationController
  def index
    if params[:query].present?
      @users = User.ransack(name_eq: params[:query]).result.order(created_at: :desc).page(params[:page]).per(10)
    else
      @users = @u.result.order(created_at: :desc).page(params[:page]).per(10)
    end
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
    user = User.find(params[:id])
    @users = user.followees.order(created_at: :desc).page(params[:page]).per(10)
  end
  # フォロワー一覧
  def followers
    user = User.find(params[:id])
    @users = user.followers.order(created_at: :desc).page(params[:page]).per(10)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :gender, :profile, :avatar, :avatar_cache)
  end
end
