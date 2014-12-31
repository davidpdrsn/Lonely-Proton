require "rails_helper"

describe MarkdownParser do
  it "parses markdown" do
    parser = build_parser
    expect(parser.parse("**hi**")).to include "<strong>hi</strong>"
  end

  it "parses and syntax highlights code" do
    parser = build_parser

    code = <<-CODE
```ruby
puts "its all good"
```
    CODE

    html = parser.parse(code)

    expect(html).to include "class=\"code\""
    expect(html).to include "pre"
  end

  it "also parses the code when no language is specified" do
    parser = build_parser

    code = <<-CODE
```
puts "its all good"
```
    CODE

    html = parser.parse(code)

    expect(html).to include "pre"
  end

  def build_parser
    renderer = HtmlAndCodeRenderer.new(
      filter_html: true,
      hard_wrap: true,
    )

    MarkdownParser.new(Redcarpet::Markdown, renderer)
  end
end
