require "delegate"
require "active_support/all"
require_relative "../../lib/composite_decorator"

describe CompositeDecorator do
  it "composes decorators and decorates and object with all of them at once" do
    obj = double
    decorator = CompositeDecorator.new([DecoratorA, DecoratorB])
    decorated_obj = decorator.decorate(obj)

    expect(decorated_obj.method_from_a).to eq "foo"
    expect(decorated_obj.method_from_b).to eq "bar"
  end
end

class DecoratorA < SimpleDelegator
  def method_from_a
    "foo"
  end
end

class DecoratorB < SimpleDelegator
  def method_from_b
    "bar"
  end
end
