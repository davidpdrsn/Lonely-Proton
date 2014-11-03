class @PreviewMarkdown
  constructor: (@parser, @textareaSelector, @previewSelector) ->

  bindEvents: ->
    @._updatePreview()
    $(document).on "keyup", $(@textarea), => @._updatePreview()

  _updatePreview: ->
    markdown = $(@textareaSelector).val()
    @parser.parse markdown, (html) =>
      $(@previewSelector).html(html)
