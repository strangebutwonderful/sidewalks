root = exports ? this # root and window are same thing in browser
root.App ?= {}
root.App.Web ?= {}
$ = jQuery

class App.Web.AjaxLoadingIndicator

  AJAX_LOADING_CLASS = "ajax-loading"

  ###
  private variables
  ###
  _$body: null
  _$document: null

  constructor: ($document, $body) ->
    @_$document = $document
    @_$body = $body

  initializeDocumentAjaxStartEventHandlers: (event) =>
    @_$body.addClass AJAX_LOADING_CLASS
    return true

  initializeDocumentAjaxStopEventHandlers: (event) =>
    @_$body.removeClass AJAX_LOADING_CLASS
    return true

  initializeDocumentAjaxEventHandlers: ->
    @_$document.ajaxStart @initializeDocumentAjaxStartEventHandlers
    @_$document.ajaxStop @initializeDocumentAjaxStopEventHandlers

$ ->
  $document = $(document)
  $body = $('body')

  new App.Web.AjaxLoadingIndicator($document, $body).initializeDocumentAjaxEventHandlers()
