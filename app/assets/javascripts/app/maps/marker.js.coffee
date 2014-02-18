#= require ./map

root = exports ? this # root and window are same thing in browser
root.App.Maps ?= {}
$ = jQuery
# L = Leaflet

class App.Maps.Marker
  ### 
  public static variables
  ###
  @selector = "[data-map-marker]"

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

    latitude = $marker.data("map-marker-latitude")
    longitude = $marker.data("map-marker-longitude")
    markerOptions = {}
    for option in App.Maps.Marker._mapMarkerOptionNames
      optionValue = $marker.data("map-marker-" + option.toLowerCase())
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