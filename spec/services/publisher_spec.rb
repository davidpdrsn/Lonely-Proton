require_relative "../../app/services/publisher"

describe Publisher do
  it "publishes posts the draft is false" do
    Timecop.freeze(Time.now) do
      post = double("post", published_at: nil)
      allow(post).to receive(:published_at=)

      Publisher.new(post).publish(is_draft: false)

      expect(post).to have_received(:published_at=).with(Time.now)
    end
  end

  it "doesn't publish the post if draft is true" do
    post = double("post")
    allow(post).to receive(:published_at=)

    Publisher.new(post).publish(is_draft: true)

    expect(post).to have_received(:published_at=).with(nil)
  end

  it "doesn't republish the post" do
    post = double("post", published_at: Time.now)
    allow(post).to receive(:published_at=)

    Publisher.new(post).publish(is_draft: false)

    expect(post).not_to have_received(:published_at=)
  end
end
