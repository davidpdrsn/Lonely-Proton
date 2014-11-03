class CompositeDecorator
  def initialize(decorators)
    @decorators = decorators
  end

  def decorate(obj)
    @decorators.inject(obj) do |acc, decorator|
      decorator.new(acc)
    end
  end

  def new(obj)
    decorate(obj)
  end
end
