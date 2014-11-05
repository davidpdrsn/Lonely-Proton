#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require prism
#= require_tree .

p = -> console.log.apply console, arguments

httpClient = new HttpClient()

$ ->
  $('a').each (i, el) ->
    unless $(el).attr('title')
      $(el).attr 'title', $(el).attr('href')

$ ->
  $("button.toggle-article-preview").click (e) ->
    e.preventDefault()
    if $(@).text() == "Hide preview"
      $(".article__preview__markdown-parse-method, .article__preview").hide()
      $(".new-post-fields").animate({ width: "90%" }, 250)
      $(".preview-markdown").animate({ width: "10%" }, 250)
      $(@).text("Show preview")
    else
      $(".article__preview__markdown-parse-method, .article__preview").show()
      $(".preview-markdown, .new-post-fields").animate({ width: "50%" }, 250)
      $(@).text("Hide preview")

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
