#= require ./map

root = exports ? this # root and window are same thing in browser
root.App.Cartography ?= {}
$ = jQuery
# L = Leaflet

class App.Cartography.Marker
  ### 
  public static variables
  ###
  @selector = "[data-cartography-map-marker]"

  ###
  private static variables
  ### 

  # Options tied to Leaflet Marker or custom ones for local 
  @_mapMarkerOptionNames: [
    'icon'
    'clickable'
    'draggable'
    'keyboard'
    'title'
    'alt'
    'zIndexOffset'
    'opacity'
    'riseOnHover'
    'riseOffset'
    'latitude'
    'longitude'
    'scrollTo'
    'track'
  ]

  # Options tied to Leaflet Icon
  @_mapMarkerIconOptionNames: [
    'iconUrl'
    'iconRetinaUrl'
    'iconSize'
    'iconAnchor'
    'shadowUrl'
    'shadowRetinaUrl'
    'shadowSize'
    'shadowAnchor'
    'popupAnchor'
    'className'
  ]

  # Options tied to Leaflet Awesome Marker
  @_awesomeIconOptionNames: [
    'icon' # see font-awesome
    'prefix' # 'fa' for font-awesome or 'glyphicon' for bootstrap 3
    'markerColor' #'red', 'darkred', 'orange', 'green', 'darkgreen', 'blue', 'purple', 'darkpuple', 'cadetblue'
    'iconColor' # 'white', 'black' or css code (hex, rgba etc)
    'spin' # true or false.
    'extraClasses' 
  ]

  ###
  private variables
  ###

  _options: null
  _map: null
  _marker: null
  _$marker: null

  constructor: (markerElement, leafletMap) ->
    @_map = leafletMap
    @_$marker = $(markerElement)
    @_options = @loadOptions()

    @attachMarker(@_options['latitude'], @_options['longitude'])
    @bindMarkerEvents()

  attachMarker: (latitude, longitude) ->
    $markerHtml = @_$marker.html()

    @_marker = L.marker([latitude, longitude], @_options).addTo(@_map)
    @_marker.bindPopup($markerHtml) unless $.trim($markerHtml).length == 0

  bindMarkerEvents: ->
    @_marker.on('click', @markerClickHander)
    if @_options['track']? && navigator && navigator.geolocation
      navigator.geolocation.watchPosition @geolocationSuccessHandler, @geolocationErrorHandler

  loadOptions: ->
    options = Lib.Options.load(App.Cartography.Marker._mapMarkerOptionNames, @_$marker, "cartography-map-marker-")

    options['icon'] = @loadIcon()

    options

  loadIcon: ->
    icon = null
    iconOptions = Lib.Options.load(App.Cartography.Marker._mapMarkerIconOptionNames, @_$marker, "cartography-map-marker-icon-")
    awesomeIconOptions = Lib.Options.load(App.Cartography.Marker._awesomeIconOptionNames, @_$marker, "cartography-map-marker-awesome-")

    if iconOptions['iconUrl']
      icon = new L.Icon(iconOptions)
    else
      icon = new L.AwesomeMarkers.Icon(awesomeIconOptions)

    icon

  markerClickHander: (event) ->
    target = event.target

    # center map to marker
    @_map.panTo(target.getLatLng(), { animate: true, duration: 2 })

    # scroll to anchor if set
    if target.options.scrollTo
      App.Web.Window.scrollToAnchor(target.options.scrollTo)

  geolocationSuccessHandler: (position) =>
    # App.Logger.debug position.coords

    latitude = position.coords.latitude
    longitude = position.coords.longitude
    
    @_marker.setLatLng([latitude, longitude])

  geolocationErrorHandler: (msg) =>
    # App.Logger.debug 'geolocation failed ' + error
    @_marker