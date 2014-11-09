require "rails_helper"

describe BuildsSlugObserver do
  it "builds a unique slug for a post when its saved" do
    post = stubbed_post
    slug_builder = double("slug_builder", unique_slug: "javascript-1")

    observer = BuildsSlugObserver.new(slug_builder)
    observer.saved(post)

    expect(post).to have_received(:slug=).with("javascript-1")
    expect(post).to have_received(:save)
  end

  it "doesn't update the slug when the post is updated" do
    post = stubbed_post
    slug_builder = double("slug_builder", unique_slug: "javascript-1")

    observer = BuildsSlugObserver.new(slug_builder)
    observer.updated(post)

    expect(post).not_to have_received(:slug=).with("javascript-1")
    expect(post).not_to have_received(:save)
  end

  def stubbed_post
    post = double("post")
    allow(post).to receive(:save)
    allow(post).to receive(:slug=)
    post
  end
end
