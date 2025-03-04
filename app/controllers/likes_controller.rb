class LikesController < ApplicationController
  before_action :set_post

  def create
    @post.with_lock do
      current_user.likes.create!(post_id: @post.id) unless current_user.likes.exists?(post_id: @post.id)
      @post.create_notification_like!(current_user)  # 通知を作成
    end

    render turbo_stream: turbo_stream.replace(
      "liked_#{@post.id}",
      partial: "likes/like",
      locals: { post: @post, liker: true },
    )
  end

  def destroy
    @post.with_lock do
      like = current_user.likes.find_by!(post_id: @post.id)
      like.destroy!
    end

    render turbo_stream: turbo_stream.replace(
      "liked_#{@post.id}",
      partial: "likes/like",
      locals: { post: @post, liker: false },
    )
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
