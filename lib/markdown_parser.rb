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

  pattr_initialize :markdown_parser_factory, :renderer

  def parse(text)
    parser.render(text).html_safe
  end

  private

  def parser
    markdown_parser_factory.new(renderer, OPTIONS)
  end
end
