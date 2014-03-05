root = exports ? this # root and window are same thing in browser
root.App.Cartography ?= {}
$ = jQuery
# L = Leaflet

class App.Cartography.Map
  ### 
  public static variables
  ###
  @selector = "[data-cartography-map]"

  ###
  private static variables
  ### 

  @_mapOptionNames: [
    'center'
    'zoom'
    'layers'
    'minZoom'
    'maxZoom'
    'maxBounds'
    'crs'
    'dragging'
    'touchZoom'
    'scrollWheelZoom'
    'doubleClickZoom'
    'boxZoom'
    'tap'
    'tapTolerance'
    'trackResize'
    'worldCopyJump'
    'closePopupOnClick'
    'bounceAtZoomLimits'
    'keyboard'
    'keyboardPanOffset'
    'keyboardZoomOffset'
    'inertia'
    'inertiaDeceleration'
    'inertiaMaxSpeed'
    'inertiaThreshold'
    'zoomControl'
    'attributionControl'
    'fadeAnimation'
    'zoomAnimation'
    'zoomAnimationThreshold'
    'markerZoomAnimation'
  ]

  ###
  private variables
  ###

  _map: null
  _$map: null

  constructor: (mapElement) ->
    @_$map = $(mapElement)
    # App.Logger.debug @_$map
    
    # compose map options

    # Assign map panel div
    @_map = L.map(@getMapPanelId(), @mapOptions())
    center = @_map.getCenter()
    zoom = @_map.getZoom()

    # Set source of map layers pngs
    L.tileLayer(@getMapTiles(), {
        attribution: @getMapAttribution()
    }).addTo(@_map)

    # Set map boundaries
    # @_map.fitBounds(getMapBounds(@_$map))
    @bindMapMarkers()

    @_map.panTo(center, { animate: true, duration: 3 })
    @_map.setZoom(zoom)
    @bindMapEvents()

  getMapTiles: () ->
    if App.Env.isProduction() && App.config('MAPBOX_ID')?
      "https://{s}.tiles.mapbox.com/v3/" + App.config('MAPBOX_ID') +  "/{z}/{x}/{y}.png"
    else
      "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"

  getMapAttribution: () ->
    attribution = 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors'
    
    mapAttributionElement = @_$map.find('[data-cartography-map-attribution]').eq(0)
    attributionHtml = $(mapAttributionElement).html()
    unless $.trim(attributionHtml).length <= 0
      attribution = attributionHtml

    attribution

  getMapPanelId: () ->
    # TODO: create an element if one doesn't exist
    mapPanelElement = @_$map.find('[data-cartography-map-panel]').eq(0)
    mapPanelElement.attr('id')

  getMapBounds: () ->
    @_$map.data("cartography-map-bounds")

  getMapCenter:() ->
    @_$map.data("cartography-map-center")

  bindMapEvents: () ->
    # 'Abstract' function for children classes

  bindMapMarkers: () ->
    # load map markers
    for markerElement in @_$map.find(App.Cartography.Marker.selector)
      new App.Cartography.Marker(markerElement, @_map)

  mapOptions: ->
    mapOptions = {}
    for option in App.Cartography.Map._mapOptionNames
      optionValue = @_$map.data("cartography-map-" + option.toLowerCase())
      mapOptions[option] = optionValue if optionValue?

    mapOptions

### 
Initialize atlases on application ready
###

$(document).on 'app.ready', ->
  $(App.Cartography.Map.selector).each (index, mapElement) ->
    new App.Cartography.Map(mapElement)