root = exports ? this # root and window are same thing in browser
root.App ?= {}
root.App.Web ?= {}
$ = jQuery

class App.Web.Window

  @getFullScreenHeight: () ->
    $(window).height()

  ###
  Smoothly scroll the browser to the given element
  @example App.Web.Window.scrollTo("#myDiv")
  @example App.Web.Window.scrollTo($jQueryObj)
  @param target selector|jQuery Object to scroll to
  ###
  @scrollTo: (target) ->
    $target = $(target)
    if($target.length)
      $("html, body").animate # body required for older browsers -_-
        scrollTop: $target.offset().top
      , 1000

  ###
  Smoothly scroll the browser to the given element
  @example App.Web.Window.scrollTo("myDiv")
  @param anchorId id (without #) of the targer scroll to
  @see scrollTo
  ###
  @scrollToAnchor: (anchorId) ->
    @scrollTo('#' + anchorId)