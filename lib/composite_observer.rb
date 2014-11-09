# Composite for combining multiple observers into one
class CompositeObserver
  pattr_initialize :observers

  def method_missing(name, *args, &block)
    observers.each do |observer|
      observer.public_send(name, *args, &block)
    end
  end
end
