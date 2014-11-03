#= require jquery
#= require radio_button_watcher

describe "RadioButtonWatcher", ->
  it "watches radio buttons and calls a callback on changes", ->
    anObject = {}
    anotherObject = {}

    watcher = new RadioButtonWatcher(
      choices:
        anObject: anObject
        anotherObject: anotherObject
      radioButtonSelector: "input[type=radio]"
    )

    radioButton = $("<input type='radio'>")
    $('body').append radioButton

    probe = 'not called'
    watcher.onChange -> probe = 'was called'

    radioButton.trigger 'change'

    expect(probe).to.equal 'was called'

  it 'updates the current choice when a radio button changes', ->
    anObject = { name: "one" }
    anotherObject = { name: "two" }

    radioButton = $("<input type='radio' value='anObject'>")
    $('body').append radioButton
    anotherRadioButton = $("<input type='radio' value='anotherObject'>")
    $('body').append anotherRadioButton

    watcher = new RadioButtonWatcher(
      choices:
        anObject: anObject
        anotherObject: anotherObject
      radioButtonSelector: "input[type=radio]"
    )

    radioButton.attr('checked', false)
    anotherRadioButton.attr('checked', 'checked').trigger('change')

    expect(watcher.currentChoice).to.equal(anotherObject)

  it 'sets the first radio button as the default', ->
    anObject = {}
    anotherObject = {}

    radioButton = $("<input type='radio' value='anObject'>")
    $('body').append radioButton
    anotherRadioButton = $("<input type='radio' value='anotherObject'>")
    $('body').append anotherRadioButton

    watcher = new RadioButtonWatcher(
      choices:
        anObject: anObject
        anotherObject: anotherObject
      radioButtonSelector: "input[type=radio]"
    )

    expect(radioButton.is ':checked').to.equal(true)
    expect(watcher.currentChoice).to.equal(anObject)
