class CompositeObserver
  def initialize(observers)
    @observers = observers
  end

  def saved(record)
    notify_observers(:saved, record)
  end

  def updated(record)
    notify_observers(:updated, record)
  end

  private

  def notify_observers(event, record)
    @observers.each do |observer|
      observer.public_send(event, record)
    end
  end
end
