class UserSessionsController < ApplicationController
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to posts_path, success: "ログインしました"
    else
      flash.now[:info] = "ログインに失敗しました"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other, flash: { success: "ログアウトしました" }
  end
end
