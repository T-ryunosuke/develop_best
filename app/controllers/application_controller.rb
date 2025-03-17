class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :require_login, :set_search
  add_flash_types :success, :info

  private

  def set_search
    @p = Post.ransack(params[:p])
    @u = User.ransack(params[:u])
  end
end
