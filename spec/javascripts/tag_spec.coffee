#= require tag

describe "Tag", ->
  it "can be created from json", ->
    tag = new Tag({ name: "foo", id: 10 })
    expect(tag.id).to.equal(10)
    expect(tag.name).to.equal("foo")

  it "uses an http client to persist itself", ->
    tag = new Tag({ name: "foo" })

    probe_url = null
    probe_data = null
    http_client = {
      post: (url, data, callback) ->
        probe_url = url
        probe_data = data
        callback({ name: "foo", id: 1 }, "success")
    }

    tag.save http_client, (success) ->
      probe_success = success

    expect(probe_url).to.equal("/api/tags")
    expect(probe_data).to.deep.equal({ tag: { name: "foo" }})
    expect(tag.id).to.equal(1)
