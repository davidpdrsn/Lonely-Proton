#=require jquery
#=require preview_markdown

describe "PreviewMarkdown", ->
  it "updates the preview element when new text is entered in the textarea", ->
    html = "<strong>hi</strong>"
    setupDom()
    newPreviewMarkdown(html).bindEvents()
    $(".textarea").val("**hi**")
    $(document).trigger("keyup")
    expect($(".preview").html()).to.equal(html)

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
