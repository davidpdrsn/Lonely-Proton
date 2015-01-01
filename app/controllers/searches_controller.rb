# Controller responsible for searching
class SearchesController < ApplicationController
  def index
    @results = dependencies[:decorated_search_result].new(
      dependencies[:search_factory].for(params[:query], type: Post),
    )
  end

  private

  def decorator
    dependencies[:search_result_decorator]
  end
end
