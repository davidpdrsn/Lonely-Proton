class PostViewLogger
  def log_view_of(post)
    PostView.create!(post: post)
  end
end
