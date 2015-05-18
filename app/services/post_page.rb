class PostPage
  def initialize(args)
    @decorator = args.fetch(:decorator)
    @logger = args.fetch(:logger)
  end

  def find(id)
    post = find_post(id)
    logger.log_view_of(post)
    decorator.new(post)
  end

  private

  attr_reader :decorator, :logger

  def find_post(id)
    Post.find(id)
  end
end
