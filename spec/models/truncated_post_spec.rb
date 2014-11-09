require "rails_helper"

describe TruncatedPost do
  it "has truncated markdown" do
    parser = double("parser")

    truncated_post = TruncatedPost.new(
      post_with_lots_of_text,
      markdown_parser: parser,
      truncate_method: ActionController::Base.helpers.method(:truncate),
      length: 100,
    )

    expect(truncated_post.markdown.length).to eq 100
    expect(truncated_post.markdown).to include "..."
    expect(truncated_post.markdown).to include "Lorem ipsum"
  end

  describe "#html" do
    it "delegates to a MarkdownParser to parse the markdown" do
      parser = double("parser")

      truncated_post = TruncatedPost.new(
        post_with_lots_of_text,
        markdown_parser: parser,
        truncate_method: ActionController::Base.helpers.method(:truncate),
        length: 100,
      )

      allow(parser).to receive(:parse).with(truncated_post.markdown)
      allow(MarkdownParser).to receive(:new).and_return(parser)

      truncated_post.html

      expect(parser).to have_received(:parse).with(truncated_post.markdown)
    end
  end

  def post_with_lots_of_text
    double("post", markdown: lots_of_text)
  end

  def lots_of_text
    <<-TEXT
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi eleifend, diam
id pulvinar faucibus, ipsum sapien ultricies tellus, at posuere ipsum magna et
justo. Vestibulum tempor fringilla egestas. Curabitur et leo quis elit mattis
commodo at quis est. Integer tempus vulputate massa, a blandit massa dapibus et.
 In tempor facilisis nisl, vitae molestie velit. Phasellus hendrerit enim vitae
 eros semper aliquam. Fusce posuere nulla id elit facilisis,
vel lobortis quam maximus
    TEXT
  end
end
