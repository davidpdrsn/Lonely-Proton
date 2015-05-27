# Controller responsible for showing the admin dashboard
class AdminController < ApplicationController
  before_filter :require_authentication

  def index
    @posts = dependencies[:admin_dashboard].new(
      Post.sorted_by_number_of_views.recently_published_first,
      Post.drafts,
    )
  end
end
