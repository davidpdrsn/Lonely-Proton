require 'github/markdown'

class MarkdownParser
  def initialize
    @parser = GitHub::Markdown
  end

  def parse(markdown)
    html = parser.render(markdown)

    if html.match(/<code>/)
      language = html.match(/lang="(?<language>.+)"/)[:language]
      html.gsub("<code>", "<code class=\"language-#{language}\">")
    else
      html
    end
  end

  private

  attr_reader :parser
end
