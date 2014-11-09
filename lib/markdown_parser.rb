# Class for parsing markdown into HTML
class MarkdownParser
  OPTIONS = {
    fenced_code_blocks: true,
    no_intra_emphasis: true,
    autolink: true,
    strikethrough: true,
    lax_html_blocks: true,
    superscript: true,
  }

  def parse(text)
    parser.render(text).html_safe
  end

  private

  def parser
    Redcarpet::Markdown.new(renderer, OPTIONS)
  end

  def renderer
    CodeRayify.new(
      filter_html: true,
      hard_wrap: true,
    )
  end
end

class CodeRayify < Redcarpet::Render::HTML
  def block_code(code, language)
    CodeRay.scan(code, language).div(css: :class)
  end
end

