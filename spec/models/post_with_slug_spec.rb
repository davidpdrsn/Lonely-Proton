require "rails_helper"

describe PostWithSlug do
  it "generates a slug for the post before its saved" do
    raw_post = double("post")
    save_result = double
    allow(raw_post).to receive(:save).and_return(save_result)
    allow(raw_post).to receive(:slug=)

    slug_builder = double("slug_builder")
    allow(slug_builder).to receive(:unique_slug)
      .with(raw_post).and_return("some_slug")

    post = PostWithSlug.new(raw_post, slug_builder)

    result = post.save

    expect(result).to eq(save_result)
    expect(raw_post).to have_received(:save)
    expect(raw_post).to have_received(:slug=).with("some_slug")
  end
end
