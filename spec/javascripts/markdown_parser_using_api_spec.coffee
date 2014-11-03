#=require markdown_parsers

describe "MarkdownParserUsingApi", ->
  it "parses markdown", ->
    http_client = {
      post: (_url, _data, callback) ->
        callback("<strong>hi</strong>")
    }

    parser = new MarkdownParserUsingApi(http_client)
    parser.parse "**hi**", (html) ->
      expect(html).to.equal("<strong>hi</strong>")

describe "NativeMarkdownParser", ->
  it "parses markdown", ->
    parser = new NativeMarkdownParser()
    parser.parse "**hi**", (html) ->
      expect(html).to.include("<strong>hi</strong>")
