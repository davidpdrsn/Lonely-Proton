require "rails_helper"

describe "tags/show.haml" do
  it "shows the posts with the given tag" do
    tag = create(:tag)
    post = PostWithPrettyDate.new(build_stubbed(:post))
    allow(tag).to receive(:posts).and_return([post])
    assign(:tag, tag)
    render

    expect(rendered).to include post.title
  end

  it "shows if there are no posts with a given tag" do
    tag = build_stubbed(:tag)
    assign(:tag, tag)
    render

    expect(rendered).to include "There are no posts with this tag"
  end
end
