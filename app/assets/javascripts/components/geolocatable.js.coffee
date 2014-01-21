geolocatableSelector = "a[data-geolocatable]";

geolocatableSuccess = (position) ->
  console.log position.coords

  latitude = position.coords.latitude
  longitude = position.coords.longitude
  
  $(geolocatableSelector).each (index, element) =>
    $elementObject = $(element)
    
    href = $elementObject.attr("href") || window.location.href
    uri = new URI(href)
    uri.removeQuery("latitude").removeQuery("longitude")
    uri.addQuery("latitude", latitude).addQuery("longitude", longitude)
    
    $elementObject.attr("href", uri.toString())
    $elementObject.attr('data-geolocatable-state', 'active');
    $elementObject.attr('disabled', false);

geolocatableError = (msg) ->
  $(geolocatableSelector).each (index, element) =>
    console.log 'geolocation failed ' + error
    $elementObject = $(element)
    $elementObject.attr('data-geolocatable-state', 'error');
    $elementObject.attr('disabled', 'disabled');

$ = jQuery

$ ->
  if navigator && navigator.geolocation
    navigator.geolocation.watchPosition geolocatableSuccess, geolocatableError
  else
    error "not supported"