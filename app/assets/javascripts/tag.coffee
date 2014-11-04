class @Tag
  constructor: (json) ->
    for key in Object.keys(json)
      @[key] = json[key]

  save: (http_client, callback) ->
    params = { tag: { name: @name } }
    http_client.post "/api/tags", params, (data, status) =>
      if status == "success"
        @id = data.id
        callback(true)
      else
        callback(false)

  # TODO: Test this
  injectIntoContainer: (container) ->
    if @id
      clone = container.find(".tag").last().clone()
      domId = "tag-" + @name.toLowerCase().replace(/\s+/g, "-")
      clone.find("input").attr("value", @id).attr("checked", true)
      clone.find("label").text(@name)
      container.append(clone)
    else
      throw "Cannot save tag without id"
