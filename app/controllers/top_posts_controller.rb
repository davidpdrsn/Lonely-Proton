class TopPostsController < ApplicationController
  def index
    @posts = dependencies[:post_collection].new(
      dependencies[:popular_posts_finder].find_posts,
    )
  end
end
