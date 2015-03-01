root = exports ? this # root and window are same thing in browser
root.App ?= {}
$ = jQuery

class App.Env
  ###
  public static variables
  ###

  ###
  private static variables
  ###

  ###
  public static methods
  ###

  @isDevelopment: ->
    'development' == App.env

  @isTest: ->
    'test' == App.env

  @isProduction: ->
    'production' == App.env