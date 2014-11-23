require "attr_extras"
require "active_support/all"

# Class for applying a decorator to a collection
class DecoratedCollection
  include Enumerable

  pattr_initialize :objects, :decorator

  delegate :present?, to: :objects

  def each(&block)
    decorated_objects.each(&block)
  end

  private

  attr_reader :objects

  def decorated_objects
    @decorated_objects ||= @objects.map { |object| @decorator.new(object) }
  end
end
