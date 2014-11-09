# Observer that associates an array of tags with a post when saved and updated
class TaggingObserver
  pattr_initialize :tags

  def saved(record)
    record.tags = tags
  end

  alias_method :updated, :saved
end
