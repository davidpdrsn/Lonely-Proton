require "rails_helper"

describe PublishablePost do
  it "publishes posts the draft is false" do
    Timecop.freeze(Time.now) do
      raw_post = stubbed_post(published_at: nil)
      allow(raw_post).to receive(:published_at=)

      post = PublishablePost.new(raw_post, is_draft: false)
      post.save

      expect(raw_post).to have_received(:published_at=).with(Time.now)
    end
  end

  it "doesn't publish the post if draft is true" do
    raw_post = stubbed_post(published_at: nil)
    allow(raw_post).to receive(:published_at=)

    post = PublishablePost.new(raw_post, is_draft: true)
    post.save

    expect(raw_post).not_to have_received(:published_at=)
  end

  it "doesn't republish the post" do
    raw_post = stubbed_post(published_at: Time.now)
    allow(raw_post).to receive(:published_at=)

    post = PublishablePost.new(raw_post, is_draft: false)
    post.save

    expect(raw_post).not_to have_received(:published_at=)
  end

  it "also calls Post#save" do
    probe = double("probe")
    raw_post = stubbed_post(published_at: Time.now)
    allow(raw_post).to receive(:published_at=)
    allow(raw_post).to receive(:save).and_return(probe)

    post = PublishablePost.new(raw_post, is_draft: false)
    result = post.save

    expect(result).to eq(probe)
  end

  def stubbed_post(options = {})
    post = double("post", options)
    allow(post).to receive(:save)
    post
  end
end
