class UserSessionsController < ApplicationController
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to posts_path, success: t("user_sessions.create.success")
    else
      flash.now[:info] = t("user_sessions.create.failure")
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other, success: t("user_sessions.destroy.success")
  end
end
