#= require marked

class @MarkdownParserUsingApi
  constructor: (@http_client) ->

  parse: (markdown, callback) ->
    @http_client.post "/api/parse_markdown", { markdown: markdown }, (html) ->
      callback html

class @NativeMarkdownParser
  parse: (markdown, callback) ->
    html = marked(markdown, {
      breaks: true
    })
    callback html
