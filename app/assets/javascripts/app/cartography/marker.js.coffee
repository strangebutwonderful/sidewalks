#= require ./map

root = exports ? this # root and window are same thing in browser
root.App.Cartography ?= {}
$ = jQuery
# L = Leaflet

class App.Cartography.Marker
  ### 
  public static variables
  ###
  @selector = "[data-cartography-map-marker]"

  ###
  private static variables
  ### 

  @_mapMarkerOptionNames: [
    'icon'
    'clickable'
    'draggable'
    'keyboard'
    'title'
    'alt'
    'zIndexOffset'
    'opacity'
    'riseOnHover'
    'riseOffset'
    'scrollTo'
  ]

  ###
  private variables
  ###

  _map: null
  _marker: null
  _$marker: null

  constructor: (markerElement, leafletMap) ->
    @_map = leafletMap
    $marker = $(markerElement)
    $markerHtml = $marker.html()

    latitude = $marker.data("cartography-map-marker-latitude")
    longitude = $marker.data("cartography-map-marker-longitude")
    markerOptions = {}
    for option in App.Cartography.Marker._mapMarkerOptionNames
      optionValue = $marker.data("cartography-map-marker-" + option.toLowerCase())
      markerOptions[option] = optionValue if optionValue?
    
    marker = L.marker([latitude, longitude], markerOptions).addTo(@_map)
    marker.bindPopup($markerHtml) unless $.trim($markerHtml).length == 0
    marker.on('click', @markerClickHander)

  markerClickHander: (event) ->
    target = event.target

    # center map to marker
    @_map.panTo(target.getLatLng(), { animate: true, duration: 2 })

    # scroll to anchor if set
    if target.options.scrollTo
      App.Browser.scrollToAnchor(target.options.scrollTo)