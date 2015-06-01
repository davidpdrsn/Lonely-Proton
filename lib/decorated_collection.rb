require "attr_extras"
require "active_support/all"

# Class for applying a decorator to a collection
class DecoratedCollection < SimpleDelegator
  include Enumerable

  pattr_initialize :objects, :decorator

  delegate :present?, to: :objects

  def method_missing(name, *args, &block)
    decorated_objects.send(name, *args, &block)
  end

  private

  def decorated_objects
    @decorated_objects ||= @objects.map { |object| @decorator.new(object) }
  end
end
