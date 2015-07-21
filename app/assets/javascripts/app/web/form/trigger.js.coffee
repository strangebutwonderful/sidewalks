root = exports ? this # root and window are same thing in browser
root.App ?= {}
root.App.Web.Form ?= {}
$ = jQuery

class App.Web.Form.Trigger
  ###
  public static variables
  ###
  @selector = '[data-form-trigger]'

  ###
  private variables
  ###
  _element: null
  _$element: null
  _form: null

  constructor: (element) ->
    @_element = element
    @_$element = $(element)
    @_form = @_$element.closest('form');
    @bindEventListeners()

  changeHandler: (event) =>
    App.Logger.debug "App.Web.Form.Trigger changeHandler"
    @_form.submit()

  bindEventListeners: ->
    @_$element.on('change', @changeHandler)

$ ->
  $(App.Web.Form.Trigger.selector).each (index, element) =>
    new App.Web.Form.Trigger(element)
