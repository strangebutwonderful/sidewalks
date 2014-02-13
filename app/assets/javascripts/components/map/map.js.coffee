###
A map expects the following:
a tag with the attribute of 'data-map'
the tag can have 0..n marker tags with the attribute of 'data-map-marker'
the tag should have at least one child tag with the attribute 'data-map-panel'

Worth remembering: `$map` is the jquery DOM object, `map` is the Leaflet map object
###

# see http://leafletjs.com/reference.html#map-options
mapOptions =
  dragging: false
  maxZoom: 18
  scrollWheelZoom: false

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

bindMapMarkers = ($map, map) ->
  # load map markers
  for markerElement in $map.find("[data-map-marker]")
    # console.log markerElement
    $marker = $(markerElement)
    $markerHtml = $marker.html()

    latitude = $marker.data("map-marker-latitude")
    longitude = $marker.data("map-marker-longitude")
    marker = L.marker([latitude, longitude]).addTo(map)
    marker.bindPopup($markerHtml) unless $.trim($markerHtml).length == 0

$ ->
  $("[data-map]").each (index, mapElement) ->
    $map = $(mapElement)
    # console.log $map
    
    # Assign map panel div
    map = L.map(getMapPanelId($map), mapOptions)

    # Set source of map layers pngs
    L.tileLayer("http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        attribution: getMapAttribution($map)
    }).addTo(map)

    # Set map boundaries
    map.fitBounds(getMapBounds($map))

    bindMapMarkers($map, map)
