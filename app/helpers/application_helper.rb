module ApplicationHelper
  # 三項演算子を使用(ifの簡略化)
  # 一旦adminとかなし
  def page_title(title = "")
    base_title = "best"
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true)
    markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true, strikethrough: true, superscript: true)
    markdown.render(text).html_safe
  end
end
