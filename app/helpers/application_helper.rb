module ApplicationHelper
  # 三項演算子を使用(ifの簡略化)
  # 一旦adminとかなし
  def page_title(title = "")
    base_title = "best"
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def markdown(text)
    # レンダリングのオプションを設定する
    render_options = {
      filter_html:     true,  # HTMLタグのフィルタリングを有効にする
      hard_wrap:       true,  # ハードラップを有効にする
      link_attributes: { target: "_blank" },  # リンクの属性を設定する
      space_after_headers: true,  # ヘッダー後のスペースを有効にする
      fenced_code_blocks: true  # フェンス付きコードブロックを有効にする
    }

    # マークダウンの拡張機能を設定する
    extensions = {
      autolink:           true,  # 自動リンクを有効にする
      no_intra_emphasis:  true,  # 単語内の強調を無効にする
      fenced_code_blocks: true,  # フェンス付きコードブロックを有効にする
      lax_spacing:        true,  # 緩いスペーシングを有効にする
      highlight:          true,  # ハイライトを有効にする
      strikethrough:      true,  # 取り消し線を有効にする
      superscript:        true  # 上付き文字を有効にする
    }

    # HTMLレンダラーを作成する
    renderer = Redcarpet::Render::HTML.new(render_options)
    # マークダウンをHTMLに変換し、結果をhtml_safeにする
    Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
  end

  def default_meta_tags
    {
      site: "best",
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

