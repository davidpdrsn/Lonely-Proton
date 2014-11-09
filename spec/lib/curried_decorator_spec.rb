require "rails_helper"

describe CurriedDecorator do
  it "curries the creation of a decorator with dependencies" do
    dependency = double("dependency")
    obj = double("obj")
    decorator = CurriedDecorator.new(ADecorator, dependency: dependency)

    decorated = decorator.new(obj)

    expect(decorated.obj).to eq obj
    expect(decorated.dependency).to eq dependency
  end
end

class ADecorator
  def initialize(obj, dependency:)
    @obj = obj
    @dependency = dependency
  end

  attr_reader :obj, :dependency
end
