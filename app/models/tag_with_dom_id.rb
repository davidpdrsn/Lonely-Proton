class TagWithDomId < SimpleDelegator
  def dom_id
    "tag-#{name.parameterize}"
  end
end
