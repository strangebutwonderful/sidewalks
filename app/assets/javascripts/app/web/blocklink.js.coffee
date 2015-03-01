root = exports ? this # root and window are same thing in browser
root.App ?= {}
root.App.Web ?= {}
$ = jQuery

class App.Web.BlockLink
  ###
  public static variables
  ###
  @selector = '[data-blocklink]'

  ###
  private variables
  ###
  _element: null
  _$element: null

  constructor: (element) ->
    @_element = element
    @_$element = $(element)
    @bindEventListeners()

  clickHandler: (event) =>
    window.location = @_$element.data('blocklink-href')

  childLinkClickHandler: (event) =>
    # prevent the child blank links from popping in same window too
    event.stopPropagation()

  bindEventListeners: ->
    @_$element.on('click', @clickHandler)
    @_$element.find('a').on('click', @childLinkClickHandler)

$ ->
  $(App.Web.BlockLink.selector).each (index, element) =>
    new App.Web.BlockLink(element)
