#= require ./map

root = exports ? this # root and window are same thing in browser
root.App.Maps ?= {}
$ = jQuery
# L = Leaflet

class App.Maps.ExploreMap extends App.Maps.Map

  ### 
  public static variables
  ###
  @selector = "[data-explore-map]"

  bindMapEvents: () ->
    super
    @_map.on('dragend', @mapMoveEndHandler)

### 
Initialize map on document ready
###

$ ->
  $(App.Maps.ExploreMap.selector).each (index, mapElement) ->
    new App.Maps.ExploreMap(mapElement)