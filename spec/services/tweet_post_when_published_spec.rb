require "rails_helper"

describe TweetPostWhenPublished do
  it "tweets about the post when its saved" do
    post = double("post", save: true, draft?: false)
    allow(tweet_factory).to receive(:new).with(post).and_return(tweet)

    TweetPostWhenPublished.new(post, client_factory, tweet_factory).save

    expect(post).to have_received(:save)
    expect(client).to have_received(:post).with(tweet)
  end

  it "doesn't tweet if the save failed" do
    post = double("post", save: false, draft?: false)
    allow(tweet_factory).to receive(:new).with(post).and_return(tweet)

    TweetPostWhenPublished.new(post, client_factory, tweet_factory).save

    expect(post).to have_received(:save)
    expect(client).not_to have_received(:post).with(tweet)
  end

  it "doesn't tweet if the post is a draft" do
    post = double("post", save: true, draft?: true)
    allow(tweet_factory).to receive(:new).with(post).and_return(tweet)

    TweetPostWhenPublished.new(post, client_factory, tweet_factory).save

    expect(post).to have_received(:save)
    expect(client).not_to have_received(:post).with(tweet)
  end

  let(:client) { double("twitter client") }
  let(:tweet) { double("tweet") }
  let(:client_factory) { double("client_factory", new: client) }
  let(:tweet_factory) { double("tweet_factory") }

  before do
    allow(client).to receive(:post).with(tweet)
  end
end
