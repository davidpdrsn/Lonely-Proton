class @RadioButtonWatcher
  constructor: (options) ->
    @choices = options.choices
    @selector = options.radioButtonSelector
    @._updateDefaultChoice()
    @.onChange =>
      @._setCurrentChoice()

  onChange: (callback) ->
    @._nodes().on 'change', =>
      callback()

  _updateDefaultChoice: ->
    @._nodes().first().attr('checked', 'checked')
    @._setCurrentChoice()

  _setCurrentChoice: ->
    key = @._nodes().filter(":checked").first().val()
    @currentChoice = @choices[key]

  _nodes: ->
    $(@selector)
