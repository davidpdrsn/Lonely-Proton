class CompositeDecorator
  pattr_initialize :decorators

  def decorate(obj)
    decorators.inject(obj) do |acc, decorator|
      decorator.new(acc)
    end
  end

  def new(obj)
    decorate(obj)
  end
end
