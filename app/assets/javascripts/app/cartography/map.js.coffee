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
  _$mapPanel: null

  constructor: (mapElement) ->
    @_$map = $(mapElement)

    # compose map options
    mapOptions = Lib.Options.load(App.Cartography.Map._mapOptionNames, @_$map, "cartography-map-")
    mapBounds = @getMapBounds()

    # Assign map panel div
    @_map = L.map(@getMapPanelId(), mapOptions)

    # Set source of map layers pngs
    L.tileLayer(@getMapTiles(), {
        attribution: @getMapAttribution()
    }).addTo(@_map)

    # Set map boundaries
    @_map.fitBounds(mapBounds)

    @bindMapMarkers()

    @bindMapEvents()

  contractMap: () ->
    @getMapPanel().removeClass('expanded')
    @getMapPanel().css('height', null)
    @_map.invalidateSize();

  expandMap: () ->
    @getMapPanel().addClass('expanded')
    @getMapPanel().css('height', App.Web.Window.getFullScreenHeight())
    @_map.invalidateSize();

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

  getMapPanel: () ->
    unless @_$mapPanel
      @getMapPanelId()

    @_$mapPanel

  getMapPanelId: () ->
    # TODO: create an element if one doesn't exist
    @_$mapPanel = @_$map.find('[data-cartography-map-panel]').eq(0) or throw new Error("Map panel not found")
    @_$mapPanel.attr('id')

  getMapBounds: () ->
    @_$map.data("cartography-map-bounds") or throw new Error("Map bounds not found")

  getMapCenter:() ->
    @_$map.data("cartography-map-center") or throw new Error("Map center not found")

  bindMapEvents: () ->
    # 'Abstract' function for children classes

  bindMapMarkers: () ->
    # load map markers
    for markerElement in @_$map.find(App.Cartography.Marker.selector)
      new App.Cartography.Marker(markerElement, @_map)

###
Initialize atlases on application ready
###

$ ->
  $(App.Cartography.Map.selector).each (index, mapElement) ->
    new App.Cartography.Map(mapElement)
