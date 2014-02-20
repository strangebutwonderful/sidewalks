root = exports ? this # root and window are same thing in browser
root.App.Geolocation ?= {}
$ = jQuery
# L = Leaflet

class App.Geolocation.Geolocatable
  ### 
  public static variables
  ###
  @selector = '[data-geolocatable]';

  ###
  private variables
  ###
  _$geolocatable: null

  constructor: (element) ->
    @_$geolocatable = $(element)
    @bindGeolocatableEvents()

  bindGeolocatableEvents: () ->
    if navigator && navigator.geolocation
      navigator.geolocation.watchPosition @geolocatableSuccessHandler, @geolocatableErrorHandler
    else
      # TODO: tell user geolocation is needed
      error 'not supported'

  setState: (state) ->
    @_$geolocatable.attr('data-geolocatable-state', state);
    if state == 'error'
      @_$geolocatable.attr('disabled', 'disabled');
    else
      @_$geolocatable.attr('disabled', false);

  geolocatableSuccessHandler: (position) =>
    # App.Logger.debug position.coords

    latitude = position.coords.latitude
    longitude = position.coords.longitude
    
    nextState = 'ready'
    
    href = @_$geolocatable.attr('href') || window.location.href
    uri = App.URILocation.replaceQuery(href, {
      latitude: latitude
      longitude: longitude
      })
    
    @_$geolocatable.attr('href', uri.toString())
    @setState(nextState)

  geolocatableErrorHandler: (msg) =>
    # App.Logger.debug 'geolocation failed ' + error
    @setState('error')

$ ->
  $(App.Geolocation.Geolocatable.selector).each (index, element) =>
    new App.Geolocation.Geolocatable(element)