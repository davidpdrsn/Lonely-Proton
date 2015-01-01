class MethodTimeTracker < SimpleDelegator
  def initialize(obj, methods_to_track)
    super(obj)
    @obj = obj
    @methods_to_track = methods_to_track
  end

  def method_missing(name, *args, &block)
    if method_should_be_tracked(name)
      track_and_print_time(name) { super }
    else
      super
    end
  end

  private

  def method_should_be_tracked(name)
    @methods_to_track.include?(name)
  end

  def track_and_print_time(name)
    start_time = Time.now
    result = yield
    end_time = Time.now
    delta_time = end_time - start_time
    message = "MethodTimeTracker: Calling \"#{name}\" on #{@obj} " \
                "took #{delta_time} seconds"
    log_message(message)

    result
  end

  def log_message(message)
    if Rails.env.test?
      puts message
    else
      Rails.logger.debug message
    end
  end
end
