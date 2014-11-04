require 'rails_helper'

describe MarkdownParser do
  it 'parses markdown' do
    parser = MarkdownParser.new
    expect(parser.parse("**hi**")).to include "<strong>hi</strong>"
  end

  it 'parses markdown with fenced code blocks' do
    parser = MarkdownParser.new
    html = parser.parse(<<-MARKDOWN)
```javascript
[1,2,3].forEach(function(n) {
  console.log(n);
});
```
    MARKDOWN

    expect(html).to include "code"
    expect(html).to include 'lang="javascript"'
    expect(html).to include 'class="language-javascript"'
    expect(html).to include "pre"
  end
end
