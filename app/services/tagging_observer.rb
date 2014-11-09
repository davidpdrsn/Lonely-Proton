class TaggingObserver
  pattr_initialize :tags

  def saved(record)
    record.tags = tags
  end

  alias_method :updated, :saved
end
