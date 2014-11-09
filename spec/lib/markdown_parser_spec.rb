require "rails_helper"

describe MarkdownParser do
  it "parses markdown" do
    parser = MarkdownParser.new
    expect(parser.parse("**hi**")).to include "<strong>hi</strong>"
  end

  it "parses and syntax highlights code" do
    parser = MarkdownParser.new

    code = <<-CODE
```ruby
puts "its all good"
```
    CODE

    html = parser.parse(code)

    expect(html).to include "class=\"code\""
    expect(html).to include "pre"
  end
end
