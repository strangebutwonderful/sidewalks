root = exports ? this # root and window are same thing in browser
root.App ?= {}

class root.App

  ### 
  public static variables
  ###
  @env: 'production'
  @configSelector = 'meta[name^=app-config]'

  ###
  private static variables
  ###
  @_config: {}

  ###
  public static methods
  ###

  @config: (key = null) ->
    if key? 
      root.App._config[key]
    else 
      root.App._config

  ###
  public methods
  ###

  constructor: ->
    root.App.env = $('meta[name=app-environment]').attr('content')
    root.App._config = @loadConfig()
    $(document).trigger('app.ready')

  loadConfig: ->
    config = {}
    $(root.App.configSelector).each (index, metaElement) ->
      $metaElement = $(metaElement)

      key = $metaElement.attr('name').replace /app-config-/, ""
      key = key.replace /-/, "_"
      key = key.toUpperCase()

      value = $metaElement.attr('content')
      
      config[key] = value

    config

$ ->
  root.app = new App();