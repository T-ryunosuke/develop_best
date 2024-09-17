class PostsController < ApplicationController
  before_action :set_category, only: %i[index show]
  helper_method :prepare_meta_tags

  def index
    if params[:query].present?
      @posts = Post.ransack(title_or_content_cont: params[:query]).result.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
    else
      if @category
        @posts = @category.posts.order(created_at: :desc).page(params[:page]).per(10)
      else
        @posts = @p.result.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
      end
    end
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
    prepare_meta_tags(@post)
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
    params.require(:post).permit(:title, :content, :category_name, { images: [] }, :images_cache)
  end

  def set_category
    @category = Category.find_by(id: params[:category_id])
  end


  def prepare_meta_tags(post)
    ## このimage_urlにMiniMagickで設定したOGPの生成した合成画像を代入する
    image_url = "#{request.base_url}/images/ogp.png?text=#{CGI.escape(post.title)}"
    set_meta_tags og: {
                    site_name: "best",
                    title: post.title,
                    description: "「best」の投稿",
                    type: "website",
                    url: request.original_url,
                    image: image_url,
                    locale: "ja-JP"
                  },
                  twitter: {
                    card: 'summary_large_image',
                    site: '@dog_kira1215',
                    image: image_url
                  }
  end
end
