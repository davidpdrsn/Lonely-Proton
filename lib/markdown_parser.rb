require 'redcarpet'

class MarkdownParser
  def initialize
    options = {
      hard_wrap: true,
      autolink: true,
      filter_html: true,
    }

    renderer = Redcarpet::Render::HTML.new(options)
    @parser = Redcarpet::Markdown.new(renderer)
  end

  def parse(markdown)
    parser.render(markdown)
  end

  private

  attr_reader :parser
end
