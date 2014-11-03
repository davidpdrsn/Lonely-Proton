#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require_tree .

p = -> console.log.apply console, arguments

$ ->
  markdownParserChooser = new RadioButtonWatcher(
    choices:
      api: new MarkdownParserUsingApi(new HttpClient()),
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
