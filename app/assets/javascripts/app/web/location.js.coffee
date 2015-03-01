root = exports ? this # root and window are same thing in browser
root.App ?= {}
root.App.Web ?= {}
$ = jQuery

class App.Web.Location

  ###
  Change the browser's location to the new url
  @example App.Web.Window.scrollTo("example.com")
  @param target url to change to
  ###
  @redirect: (target) ->
    root.location = target

  @url: ->
    root.location
