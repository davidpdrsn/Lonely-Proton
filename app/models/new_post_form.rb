class NewPostForm
  def initialize(post, tags)
    @post = post
    @tags = tags
  end

  attr_reader :post, :tags

  def new?
    @post.new_record?
  end
end
