geolocatableSelector = "a[data-geolocatable=true]";

geolocatableSuccess = (position) ->
  console.log position.coords

  nearbyParams = 
    latitude: position.coords.latitude
    longitude: position.coords.longitude
  
  $(geolocatableSelector).each (index, element) =>
    $elementObject = $(element)
    $elementObject.attr("href", '/noises/?' + $.param( nearbyParams ))
    $elementObject.removeClass('hidden')

geolocatableError = (msg) ->
  $(geolocatableSelector).each (index, element) =>
    console.log 'geolocation failed' + error
    $elementObject = $(element)
    $elementObject.addClass('hidden')

$ = jQuery

$ ->
  if navigator && navigator.geolocation
    navigator.geolocation.watchPosition geolocatableSuccess, geolocatableError
  else
    error "not supported"