module ApplicationHelper
  # 三項演算子を使用(ifの簡略化)
  # 一旦adminとかなし
  def page_title(title = "")
    base_title = "best"
    title.present? ? "#{title} | #{base_title}" : base_title
  end
end
