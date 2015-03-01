root = exports ? this # root and window are same thing in browser
root.App ?= {}
$ = jQuery

class App.Logger
  ### 
  public static variables
  ###

  ###
  private static variables
  ### 
  @Severity: class Severity
    @DEBUG: 0
    @INFO: 1
    @WARN: 2
    @ERROR: 3
    @FATAL: 4
    @UNKNOWN: 5

  @level: Logger.Severity.DEBUG

  @add: (severity, message = nil) ->
    severity ||= App.Logger.Severity.UNKNOWN
    unless severity < App.Logger.level 
      if root.console?
        root.console.log message

  @debug: (message) ->
    App.Logger.add(App.Logger.Severity.DEBUG, message)

  @info: (message) ->
    App.Logger.add(App.Logger.Severity.INFO, message)

  @warn: (message) ->
    App.Logger.add(App.Logger.Severity.WARN, message)

  @error: (message) ->
    App.Logger.add(App.Logger.Severity.ERROR, message)

  @fatal: (message) ->
    App.Logger.add(App.Logger.Severity.FATAL, message)