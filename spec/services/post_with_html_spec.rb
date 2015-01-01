require "rails_helper"

describe PostWithHtml do
  it "parses the markdown on save and update" do
    markdown = "**hi**"
    html = "<strong>hi</strong>"
    raw_post = double("raw_post", markdown: markdown)
    allow(raw_post).to receive(:save)
    allow(raw_post).to receive(:html=)
    parser = double("parser")
    allow(parser).to receive(:parse).with(markdown).and_return(html)

    post = PostWithHtml.new(raw_post, parser)
    post.save

    expect(raw_post).to have_received(:html=).with(html)
  end
end
