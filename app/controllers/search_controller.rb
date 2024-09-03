class SearchController < ApplicationController
  def search
    model_type = params[:model_type]
    query = params[:query]
    if model_type == "post"
      redirect_to posts_path(query: query) # 投稿検索結果のビュー
    elsif model_type == "user"
      redirect_to users_path(query: query) # ユーザー検索結果のビュー
    else
      # デフォルトの動作やエラーハンドリング
      redirect_back(fallback_location: root_path)
    end
  end
end
