#=require jquery
#=require preview_markdown

describe "PreviewMarkdown", ->
  it "updates the preview element when new text is entered in the textarea", ->
    setupDom()

    first = true
    markdownParser = {
      parse: (_markdown, callback) ->
        if first
          callback "<strong>bar</strong>"
          first = false
        else
          callback "<strong>foo</strong>"
    }

    new PreviewMarkdown(markdownParser, "textarea", ".preview").bindEvents()
    $(".textarea").val("**foo**")
    $(document).trigger("keyup")
    console.log $(".preview").html()
    expect($(".preview").html()).to.equal("<strong>foo</strong>")

  it 'updates the preview when the page loads', ->
    html = "<strong>hi</strong>"
    setupDom()
    $(".textarea").val("**hi**")
    newPreviewMarkdown(html).bindEvents()
    expect($(".preview").html()).to.equal(html)

setupDom = ->
  $("body")
    .append("<textarea />")
    .append("<div class='preview' />")

newPreviewMarkdown = (html) ->
  markdownParser = {
    parse: (_markdown, callback) ->
      callback html
  }
  new PreviewMarkdown(markdownParser, "textarea", ".preview")
