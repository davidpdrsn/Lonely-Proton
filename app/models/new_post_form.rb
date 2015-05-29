# Facade for a post used in form, and a collection of tags
class NewPostForm
  def initialize(post, tags)
    @post = post
    @tags = tags
  end

  attr_reader :post, :tags

  def new?
    @post.new_record?
  end

  delegate :save, to: :post
  delegate :draft?, to: :post
end
