geolocatableSelector = 'a[data-geolocatable]';

geolocatableSuccess = (position) ->
  # console.log position.coords

  latitude = position.coords.latitude
  longitude = position.coords.longitude
  
  $(geolocatableSelector).each (index, element) =>
    $elementObject = $(element)
    nextState = 'ready'
    
    href = $elementObject.attr('href') || window.location.href
    uri = new URI(href)
    
    uriQuery = uri.query(true);
    if(Number(uriQuery['latitude']) == latitude && Number(uriQuery['longitude']) == longitude)
      nextState = 'waiting'

    uri.removeQuery('latitude').removeQuery('longitude')
    uri.addQuery('latitude', latitude).addQuery('longitude', longitude)
    
    $elementObject.attr('href', uri.toString())
    $elementObject.attr('data-geolocatable-state', nextState);
    $elementObject.attr('disabled', false);

geolocatableError = (msg) ->
  $(geolocatableSelector).each (index, element) =>
    # console.log 'geolocation failed ' + error
    $elementObject = $(element)
    $elementObject.attr('data-geolocatable-state', 'error');
    $elementObject.attr('disabled', 'disabled');

$ = jQuery

$ ->
  if navigator && navigator.geolocation
    navigator.geolocation.watchPosition geolocatableSuccess, geolocatableError
  else
    error 'not supported'