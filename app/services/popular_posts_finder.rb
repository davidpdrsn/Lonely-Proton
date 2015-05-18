class PopularPostsFinder
  def find_posts
    sort(considered_posts).take(5)
  end

  private

  def sort(posts)
    posts.sort_by!(&:number_of_views).reverse!
  end

  def considered_posts
    Post
      .recently_published_first
      .to_a
  end
end
