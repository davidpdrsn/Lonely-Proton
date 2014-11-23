require "delegate"

# Decorator adding observers to a record
class ObservableRecord < SimpleDelegator
  def initialize(record, observer)
    super(record)
    @record = record
    @observer = observer
  end

  def save
    track_save { record.save }
  end

  def update(attributes)
    track_update { record.update(attributes) }
  end

  private

  attr_reader :record, :observer

  def track_save
    if yield
      notify_saved(record.persisted?)
      true
    else
      false
    end
  end

  alias_method :track_update, :track_save

  def notify_saved(persisted)
    if persisted
      observer.updated(record)
    else
      observer.saved(record)
    end

    record.save
  end
end
