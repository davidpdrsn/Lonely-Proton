class @PreviewMarkdown
  constructor: (@parser, @textareaSelector, @previewSelector) ->

  bindEvents: ->
    if $(@textareaSelector).length
      @._updatePreview()
      $(document).on "keyup", $(@textareaSelector), => @._updatePreview()

  _updatePreview: ->
    markdown = $(@textareaSelector).val()
    @parser.parse markdown, (html) =>
      $(@previewSelector).html(html)
# TODO: Test that this line gets called
      Prism.highlightAll true, ->
