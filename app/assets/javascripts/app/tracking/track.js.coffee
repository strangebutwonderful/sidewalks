root = exports ? this # root and window are same thing in browser
root.App.Tracking ?= {}
$ = jQuery

class App.Tracking.Track

  constructor: (element) ->
    @bindGeolocationEvents()

  bindGeolocationEvents: () ->
    if navigator && navigator.geolocation
      navigator.geolocation.watchPosition @geolocatableSuccessHandler

  geolocatableSuccessHandler: (position) =>
    #App.Logger.debug "Track geolocation success: #{position.coords}"

    latitude = position.coords.latitude
    longitude = position.coords.longitude

    # Set cookie
    $.cookie('latlng', "#{latitude},#{longitude}")

$ ->
  new App.Tracking.Track();