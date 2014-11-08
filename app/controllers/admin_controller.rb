class AdminController < ApplicationController
  before_filter :require_authentication

  def index
    @posts = AdminDashboard.new(
      published: Post.recently_published_first,
      drafts: Post.drafts
    )
  end
end
