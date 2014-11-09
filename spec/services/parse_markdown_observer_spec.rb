require "rails_helper"

describe ParseMarkdownObserver do
  it "parses the markdown on save and update" do
    markdown = "**hi**"
    html = "<strong>hi</strong>"
    post = double("post", markdown: markdown, save: true)
    allow(post).to receive(:html=)
    parser = double("parser")
    allow(parser).to receive(:parse).with(markdown).and_return(html)

    observer = ParseMarkdownObserver.new(parser)
    observer.saved(post)
    observer.updated(post)

    expect(post).to have_received(:html=).with(html).twice
  end
end
