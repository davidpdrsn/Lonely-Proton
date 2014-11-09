# Decorator that adds dom id to a tag
class TagWithDomId < SimpleDelegator
  def dom_id
    "tag-#{name.parameterize}"
  end
end
