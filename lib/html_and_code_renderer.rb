class HtmlAndCodeRenderer < Redcarpet::Render::HTML
  def block_code(code, language)
    CodeRay.scan(code, (language || "no_language")).div(css: :class)
  end
end
