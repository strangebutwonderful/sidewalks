#= require nanobar/nanobar

root = exports ? this # root and window are same thing in browser
root.App ?= {}
root.App.Web ?= {}
$ = jQuery

class App.Web.LoadingIndicator
  ###
  public static variables
  ###
  @selector = '[data-loading-indicator]'

  ###
  private static variables
  ###
  @_loadingIndicatorOptions: [
    'background-color'
    'completed-length'
    'in-progress-length'
    'starting-length'
  ]

  ###
  private variables
  ###
  _$document: null
  _$element: null
  _element: null
  _nanobar: null

  _starting_length: 0
  _in_progress_length: 90
  _completed_length: 100

  constructor: ($document, element) ->
    @_element = element
    @_$element = $(element)
    @_$document = $document

    loadingIndicatorOptions = Lib.Options.load(App.Web.LoadingIndicator._loadingIndicatorOptions, @_$element, "loading-indicator-")

    @_starting_length = loadingIndicatorOptions[ 'starting-length' ] if loadingIndicatorOptions[ 'starting-length' ]
    @_in_progress_length = loadingIndicatorOptions[ 'in-progress-length' ] if loadingIndicatorOptions[ 'in-progress-length' ]
    @_completed_length = loadingIndicatorOptions[ 'completed-length' ] if loadingIndicatorOptions[ 'completed-length' ]

    @_nanobar = new Nanobar({
      bg: (loadingIndicatorOptions['background-color'] || "#ffffff"),
      target: @_element
    })
    @_nanobar.go @_starting_length

    @bindEventListeners()

  documentClickHandler: (event) =>
    @_nanobar.go @_in_progress_length

  bindEventListeners: ->
    @_$document.on('click', 'a', @documentClickHandler)

$ ->
  $document = $(document)

  $(App.Web.LoadingIndicator.selector).each (index, element) ->
    new App.Web.LoadingIndicator($document, element)
