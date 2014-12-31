# Controller responsible for searching
class SearchesController < ApplicationController
  def index
    @results = dependencies[:decorated_search_result].new(
      Search.new.for(params[:query], type: Post),
    )
  end

  private

  def decorator
    dependencies[:search_result_decorator]
  end
end
