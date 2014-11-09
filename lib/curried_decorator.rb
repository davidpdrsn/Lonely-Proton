# Class for currying the creation of a decorator
# Useful for making decorators with prespecified dependencies
class CurriedDecorator
  def initialize(decorator, *args)
    @decorator = decorator
    @args = args
  end

  def new(*args)
    @decorator.new(*args.concat(@args))
  end
end
