require 'redcarpet'

class MarkdownParser
  def initialize
    @parser = Redcarpet::Markdown.new(renderer)
  end

  def parse(markdown)
    parser.render(markdown)
  end

  private

  attr_reader :parser

  OPTIONS = {
    hard_wrap: true,
    autolink: true,
    filter_html: true,
  }

  def renderer
    Redcarpet::Render::HTML.new(OPTIONS)
  end
end
