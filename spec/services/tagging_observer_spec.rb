require "rails_helper"

describe TaggingObserver do
  it "assigns the tags to the post" do
    post = double("post")
    tag = double("tag")
    allow(post).to receive(:tags=).with([tag])

    observer = TaggingObserver.new([tag])
    observer.saved(post)
    observer.updated(post)

    expect(post).to have_received(:tags=).with([tag]).twice
  end
end
