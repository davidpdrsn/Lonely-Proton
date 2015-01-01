require "attr_extras"

# Composite for combining multiple decorators into one
class CompositeDecorator
  pattr_initialize :decorators

  def new(obj)
    decorators.inject(obj) do |acc, decorator|
      decorator.new(acc)
    end
  end
end
