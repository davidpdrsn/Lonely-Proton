class TagFinder
  def initialize(tag_relation, tag_decorator, posts_collection_decorator)
    @tag_relation = tag_relation
    @tag_decorator = tag_decorator
    @posts_collection_decorator = posts_collection_decorator
  end

  def find(id)
    @tag_decorator.new(@tag_relation.find(id), @posts_collection_decorator)
  end
end
