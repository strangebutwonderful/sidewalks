#= require ./map

root = exports ? this # root and window are same thing in browser
root.App.Cartography ?= {}
$ = jQuery
# L = Leaflet

class App.Cartography.ExploreMap extends App.Cartography.Map

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
  $(App.Cartography.ExploreMap.selector).each (index, mapElement) ->
    new App.Cartography.ExploreMap(mapElement)