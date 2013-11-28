$ = jQuery

$ ->
  for mapElement in $("[data-map]") 
    map = L.map(mapElement)

    L.tileLayer("http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors',
        maxZoom: 18
    }).addTo(map)

    for mappable in $("[data-mappable]")

      $mappable = $(mappable)
      latitude = $mappable.data("mappable-latitude")
      longitude = $mappable.data("mappable-longitude")
      name = $mappable.data("mappable-name")
      details = $mappable.data("mappable-details")
      marker = L.marker([latitude, longitude]).addTo(map)
      marker.bindPopup("<b>#{name}</b><br>#{details}")

      currentPosition = new L.LatLng(latitude, longitude)
      map.setView(currentPosition, 16)