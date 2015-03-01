root = exports ? this # root and window are same thing in browser
root.App ?= {}
root.App.Web.Events ?= {}
root.App.Web.Events.Page ?= {}
$ = jQuery

class App.Web.Events.Page.Transition
