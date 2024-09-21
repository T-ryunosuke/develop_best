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

  def default_meta_tags
    {
      site: "best",
      title: "best",
      reverse: true,
      charset: "utf-8",
      description: "あなたがbestと感じた「もの」「場所」「体験」を投稿するSNS型のレビューアプリ",
      keywords: "best, ベスト, ランキング, SNS, レビュー, 投稿",
      canonical: request.original_url,
      og: {
        site_name: "best",
        title: "best",
        description: "あなたがbestと感じた「もの」「場所」「体験」を投稿するSNS型のレビューアプリ",
        type: "website",
        url: request.original_url,
        image: image_url("defaults.png"),
        local: "ja-JP"
      },
      twitter: {
        card: "summary_large_image",
        site: "@dog_kira1215",
        image: image_url("defaults.png")
      }
    }
  end
end
