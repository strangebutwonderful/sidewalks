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
    'scrollTo'
  ]

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

  _map: null
  _marker: null
  _$marker: null

  constructor: (markerElement, leafletMap) ->
    @_map = leafletMap
    @_$marker = $(markerElement)
    $markerHtml = @_$marker.html()

    latitude = @_$marker.data("cartography-map-marker-latitude")
    longitude = @_$marker.data("cartography-map-marker-longitude")
    
    markerOptions = @loadOptions()
    
    @_marker = L.marker([latitude, longitude], markerOptions).addTo(@_map)
    @_marker.bindPopup($markerHtml) unless $.trim($markerHtml).length == 0
    @_marker.on('click', @markerClickHander)

  loadOptions: ->
    options = {}
    for option in App.Cartography.Marker._mapMarkerOptionNames
      optionValue = @_$marker.data("cartography-map-marker-" + option.toLowerCase())
      options[option] = optionValue if optionValue?

    options['icon'] = @loadIcon()

    options

  loadIcon: ->
    icon = null
    options = @loadIconOptions()
    awesomeOptions = @load

    if options['iconUrl']
      icon = new L.Icon(options)
    else
      icon = new L.AwesomeMarkers.Icon(options)

    icon

  loadIconOptions: ->
    options = {}
    for option in App.Cartography.Marker._mapMarkerIconOptionNames
      optionValue = @_$marker.data("cartography-map-marker-icon-" + option.toLowerCase())
      options[option] = optionValue if optionValue?

    options

  loadAwesomeIconOptions: ->
    options = {}
    for option in App.Cartography.Marker._awesomeIconOptionNames
      optionValue = @_$marker.data("cartography-map-marker-awesome-" + option.toLowerCase())
      options[option] = optionValue if optionValue?

    options    

  markerClickHander: (event) ->
    target = event.target

    # center map to marker
    @_map.panTo(target.getLatLng(), { animate: true, duration: 2 })

    # scroll to anchor if set
    if target.options.scrollTo
      App.Web.Window.scrollToAnchor(target.options.scrollTo)