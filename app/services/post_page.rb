class PostPage
  pattr_initialize :decorator

  def find(id)
    decorator.new(find_post(id))
  end

  private

  def find_post(id)
    Post.find(id)
  end
end
