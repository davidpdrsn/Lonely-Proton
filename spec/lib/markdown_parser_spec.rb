require 'rails_helper'

describe MarkdownParser do
  it 'parses markdown' do
    parser = MarkdownParser.new
    expect(parser.parse("**hi**")).to include "<strong>hi</strong>"
  end
end
