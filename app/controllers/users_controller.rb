class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  # アカウント作成ページ
  def new
    @user = User.new
  end

  # アカウント登録処理
  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to root_path, success: t("users.create.success")
    else
      flash.now[:info] = t("users.create.failure")
      render :new, status: :unprocessable_entity
    end
  end

  # ユーザー一覧ページ
  def index
    if params[:query].present?
      @users = User.ransack(name_eq: params[:query]).result.order(created_at: :desc).page(params[:page]).per(12)
    else
      @users = User.order(created_at: :desc).page(params[:page]).per(12)
    end
  end

  # プロフィール詳細ページ（どのユーザーでもOK）
  def show
    @user = User.find(params[:id])
  end

  # お気に入り投稿一覧ページ
  def liked_posts
    @posts = current_user.liked_posts.includes(:category).order(created_at: :desc).page(params[:page])
  end

  # フォロイー一覧ページ
  def followees
    user = User.find(params[:id])
    @users = user.followees.order(created_at: :desc).page(params[:page]).per(10)
  end

  # フォロワー一覧ページ
  def followers
    user = User.find(params[:id])
    @users = user.followers.order(created_at: :desc).page(params[:page]).per(10)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :gender, :profile, :avatar, :avatar_cache)
  end
end
