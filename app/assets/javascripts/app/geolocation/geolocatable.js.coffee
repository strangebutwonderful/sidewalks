root = exports ? this # root and window are same thing in browser
root.App.Geolocation ?= {}
$ = jQuery

class App.Geolocation.Geolocatable
  ###
  public static variables
  ###
  @selector = '[data-geolocatable]';

  @ERRORSTATE = 'error'
  @HERESTATE = 'here' # User at location
  @MOVEDSTATE = 'moved' # User not at location

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

    latlngQuery = {
      latitude: position.coords.latitude
      longitude: position.coords.longitude
      }

    href = @_$geolocatable.attr('href') || window.location.href

    nextState = App.Geolocation.Geolocatable.HERESTATE

    unless App.URILocation.queryContains(href, latlngQuery)
      nextState = App.Geolocation.Geolocatable.MOVEDSTATE # TODO: if new latlng is same, set state as

    uri = App.URILocation.replaceQuery(href, latlngQuery)

    @_$geolocatable.attr('href', uri.toString())
    @setState(nextState)

  geolocatableErrorHandler: (msg) =>
    @setState(App.Geolocation.Geolocatable.ERRORSTATE)

$ ->
  $(App.Geolocation.Geolocatable.selector).each (index, element) =>
    new App.Geolocation.Geolocatable(element)