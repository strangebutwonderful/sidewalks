###
A map expects the following:
a tag with the attribute of 'data-map'
the tag can have 0..n marker tags with the attribute of 'data-map-marker'
the tag should have at least one child tag with the attribute 'data-map-panel'
###

$ = jQuery

$ ->
  $("[data-map]").each (index, mapElement) ->
    $map = $(mapElement)
    console.log $map
    
    # Assign map panel div
    mapPanelElement = $map.find('[data-map-panel]').eq(0)
    map = L.map(mapPanelElement.attr('id'))

    # Set source of map layers pngs
    L.tileLayer("http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors',
        maxZoom: 18
    }).addTo(map)

    # Set map boundaries
    mapBounds = $map.data("map-bounds")
    console.log mapBounds
    map.fitBounds(mapBounds)

    # load map markers
    for markerElement in $map.find("[data-map-marker]")
      console.log markerElement
      $marker = $(markerElement)

      latitude = $marker.data("map-marker-latitude")
      longitude = $marker.data("map-marker-longitude")
      name = $marker.data("map-marker-name")
      details = $marker.data("map-marker-details")
      marker = L.marker([latitude, longitude]).addTo(map)
      marker.bindPopup("<b>#{name}</b><br>#{details}")