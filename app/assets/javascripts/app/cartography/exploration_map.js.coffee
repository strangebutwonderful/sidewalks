#= require ./map

class App.Cartography.ExplorationMap extends App.Cartography.Map

  ###
  public static variables
  ###
  @selector = "[data-cartography-explorationmap]"

  constructor: (mapElement) ->
    super mapElement

    @_map.addControl( L.control.zoom({position: 'bottomright'}) )

  mapClickHandler:(event) =>
    App.Web.Window.scrollTo(@_$map)
    @expandMap()

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
    @_map.on('click', @mapClickHandler)

###
Initialize map on document ready
###

$ ->
  $(App.Cartography.ExplorationMap.selector).each (index, mapElement) ->
    new App.Cartography.ExplorationMap(mapElement)
