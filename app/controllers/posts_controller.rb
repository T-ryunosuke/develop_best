class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save_with_category(post_params[:category_name])
      redirect_to posts_path(@post), success: t("posts.create.success")
    else
      flash.now[:info] = t("posts.create.failure")
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update_with_category(post_params)
      redirect_to post_path(@post), success: t("posts.update.success")
    else

      flash.now[:info] = t("posts.update.failure")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
    redirect_to posts_path, success: t("posts.delete.success"), status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :category_name, {images: []}, :images_cache)
  end
end
