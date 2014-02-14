###
A map expects the following:
a tag with the attribute of 'data-map'
the tag can have 0..n marker tags with the attribute of 'data-map-marker'
the tag should have at least one child tag with the attribute 'data-map-panel'

Worth remembering: `$map` is the jquery DOM object, `map` is the Leaflet map object
###

# see http://leafletjs.com/reference.html#map-options
# mapOptions =
#   dragging: false
#   maxZoom: 18
#   scrollWheelZoom: false

mapOptionNames = [
  'center'
  'zoom'
  'layers'
  'minZoom'
  'maxZoom'
  'maxBounds'
  'crs'
  'dragging'
  'touchZoom'
  'scrollWheelZoom'
  'doubleClickZoom'
  'boxZoom'
  'tap'
  'tapTolerance'
  'trackResize'
  'worldCopyJump'
  'closePopupOnClick'
  'bounceAtZoomLimits'
  'keyboard'
  'keyboardPanOffset'
  'keyboardZoomOffset'
  'inertia'
  'inertiaDeceleration'
  'inertiaMaxSpeed'
  'inertiaThreshold'
  'zoomControl'
  'attributionControl'
  'fadeAnimation'
  'zoomAnimation'
  'zoomAnimationThreshold'
  'markerZoomAnimation'
]
mapMarkerOptionNames = ['icon', 'clickable', 'draggable', 'keyboard', 'title', 'alt', 'zIndexOffset', 'opacity', 'riseOnHover', 'riseOffset']

$ = jQuery

getMapAttribution = ($map) ->
  attribution = 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors'
  
  mapAttributionElement = $map.find('[data-map-attribution]').eq(0)
  attributionHtml = $(mapAttributionElement).html()
  unless $.trim(attributionHtml).length <= 0
    attribution = attributionHtml

  attribution

getMapPanelId = ($map) ->
  # TODO: create an element if one doesn't exist
  mapPanelElement = $map.find('[data-map-panel]').eq(0)
  mapPanelElement.attr('id')

getMapBounds = ($map) ->
  $map.data("map-bounds")

getMapCenter = ($map) ->
  $map.data("map-center")

bindMapMarkers = ($map, map) ->
  # load map markers
  for markerElement in $map.find("[data-map-marker]")
    # console.log markerElement
    $marker = $(markerElement)
    $markerHtml = $marker.html()

    latitude = $marker.data("map-marker-latitude")
    longitude = $marker.data("map-marker-longitude")
    markerOptions = {}
    for option in mapMarkerOptionNames
      optionValue = $marker.data("map-marker-" + option.toLowerCase())
      markerOptions[option] = optionValue if optionValue?
    
    marker = L.marker([latitude, longitude], markerOptions).addTo(map)
    marker.bindPopup($markerHtml) unless $.trim($markerHtml).length == 0

$ ->
  $("[data-map]").each (index, mapElement) ->
    $map = $(mapElement)
    # console.log $map
    
    mapOptions = {}
    for option in mapOptionNames
      optionValue = $map.data("map-" + option.toLowerCase())
      mapOptions[option] = optionValue if optionValue?

    # Assign map panel div
    map = L.map(getMapPanelId($map), mapOptions)

    # Set source of map layers pngs
    L.tileLayer("http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        attribution: getMapAttribution($map)
    }).addTo(map)

    # Set map boundaries
    map.fitBounds(getMapBounds($map))
    bindMapMarkers($map, map)

    
    setTimeout ( =>
      map.panTo(getMapCenter($map), { animate: true, duration: 3 })
      map.setZoom(map.getZoom() + 4)
    ), 2000
