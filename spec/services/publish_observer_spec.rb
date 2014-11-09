require "rails_helper"

describe PublishObserver do
  it "publishes posts the draft is false" do
    Timecop.freeze(Time.now) do
      post = stubbed_post(published_at: nil)
      allow(post).to receive(:published_at=)

      observer = PublishObserver.new(is_draft: false)
      observer.saved(post)

      expect(post).to have_received(:published_at=).with(Time.now)
    end
  end

  it "doesn't publish the post if draft is true" do
    post = stubbed_post(published_at: nil)
    allow(post).to receive(:published_at=)

    observer = PublishObserver.new(is_draft: true)
    observer.saved(post)

    expect(post).not_to have_received(:published_at=)
  end

  it "doesn't republish the post" do
    post = stubbed_post(published_at: Time.now)
    allow(post).to receive(:published_at=)

    observer = PublishObserver.new(is_draft: false)
    observer.saved(post)

    expect(post).not_to have_received(:published_at=)
  end

  def stubbed_post(options = {})
    post = double("post", options)
    post
  end
end
