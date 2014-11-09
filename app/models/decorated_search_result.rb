require "delegate"

class DecoratedSearchResult < SimpleDelegator
  def initialize(results, decorator, decorated_collection_factory:)
    super(results)
    @decorator = decorator
    @decorated_collection_factory = decorated_collection_factory
  end

  def posts
    @decorated_posts ||= build_decorated_posts
  end

  private

  def build_decorated_posts
    @decorated_collection_factory.new(__getobj__.posts, @decorator)
  end
end
