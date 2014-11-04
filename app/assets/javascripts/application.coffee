#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require_tree .

p = -> console.log.apply console, arguments

httpClient = new HttpClient()

$ ->

  $(document).on "click", "#create-new-tag", (e) ->
    e.preventDefault()
    name = $("#new_tag_name").val()

    tag = new Tag(name: name)
    tag.save httpClient, (success) ->
      if success
        tag.injectIntoContainer $(".tags")
      else
        alert "Tag was invalid or already created"

$ ->

  markdownParserChooser = new RadioButtonWatcher(
    choices:
      api: new MarkdownParserUsingApi(httpClient),
      native: new NativeMarkdownParser()
    radioButtonSelector: "input[type=radio][name=markdown-parse-method]"
  )

  previewer = new PreviewMarkdown(
    markdownParserChooser.currentChoice,
    "textarea#post_markdown",
    ".article__preview"
  )
  previewer.bindEvents()

  markdownParserChooser.onChange ->
    previewer.parser = markdownParserChooser.currentChoice
