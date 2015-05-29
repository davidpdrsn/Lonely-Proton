class TweetPostWhenPublished < SimpleDelegator
  def initialize(post, client_factory, tweet_factory)
    super(post)
    @post = post
    @client_factory = client_factory
    @tweet_factory = tweet_factory
  end

  def save
    success = super
    if success && !post.draft?
      client_factory.new.post(tweet)
    end
    success
  end

  private

  attr_reader :post, :client_factory, :tweet_factory

  def tweet
    tweet_factory.new(post)
  end
end
