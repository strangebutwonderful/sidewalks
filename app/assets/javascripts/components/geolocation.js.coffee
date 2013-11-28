success = (position) ->
  console.log position.coords

  nearbyParams = 
    latitude: position.coords.latitude
    longitude: position.coords.longitude
  
  $("a[data-geolocatable=true]").each (index, element) =>
    $elementObject = $(element)
    $elementObject.attr("href", '/noises/?' + $.param( nearbyParams ))
    $elementObject.removeClass('hidden')

error = (msg) ->
  window.location = '/noises/?'

$ = jQuery

$ ->
  if navigator.geolocation
    navigator.geolocation.watchPosition success, error
  else
    error "not supported"