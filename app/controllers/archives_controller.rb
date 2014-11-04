class ArchivesController < ApplicationController
  def index
    @posts = DecoratedCollection.new(Post.sorted, PostWithPrettyDate)
  end
end
