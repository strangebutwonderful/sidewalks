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
  private variables
  ###
  _$document: null
  _$element: null
  _element: null
  _nanobar: null

  constructor: ($document, element) ->
    @_element = element
    @_$element = $(element)
    @_$document = $document
    @_nanobar = new Nanobar({
      bg: "#00354F",
      target: @_element
    })

    @bindEventListeners()

  documentClickHandler: (event) =>
    @_nanobar.go 100

  bindEventListeners: ->
    @_$document.on('click', 'a', @documentClickHandler)

$ ->
  $document = $(document)

  $(App.Web.LoadingIndicator.selector).each (index, element) =>
    new App.Web.LoadingIndicator($document, element)
