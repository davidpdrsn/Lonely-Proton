class PostWithHtml < PostPersistHook
  def initialize(post, parser)
    super(post)
    @post = post
    @parser = parser
  end

  def save
    @post.html = @parser.parse(@post.markdown)
    @post.save
  end
end
