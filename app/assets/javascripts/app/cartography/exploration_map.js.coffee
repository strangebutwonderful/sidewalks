#= require ./map

root = exports ? this # root and window are same thing in browser
root.App.Cartography ?= {}
$ = jQuery
# L = Leaflet

class App.Cartography.ExplorationMap extends App.Cartography.Map

  ### 
  public static variables
  ###
  @selector = "[data-cartography-explorationmap]"

  mapMoveEndHandler:(event) =>
    center = @_map.getCenter()
    latitude = center.lat
    longitude = center.lng
      
    uri = App.URILocation.replaceQuery(window.location, {
      latitude: latitude
      longitude: longitude
      zoom: @_map.getZoom()
      })

    # TODO: don't reload the whole page, just show new listings
    window.location = uri.toString()

  bindMapEvents: () ->
    super
    @_map.on('dragend', @mapMoveEndHandler)

### 
Initialize map on document ready
###

$ ->
  $(App.Cartography.ExplorationMap.selector).each (index, mapElement) ->
    new App.Cartography.ExplorationMap(mapElement)