class PopularPostsFinder
  def find_posts
    Post.all.to_a.sort_by!(&:number_of_views).reverse!.take(5)
  end
end
