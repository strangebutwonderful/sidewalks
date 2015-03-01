root = exports ? this # root and window are same thing in browser
root.App ?= {}
$ = jQuery

class App.URILocation

  ###
  Helper function that checks if the uri already contains the query params with the
  specified values
  @param URI|string of url to update
  @param hash of query parameter whose existance will be compared against the uri
  @return boolean true if each param is found with the given value
  ###
  @queryContains: (uri, params) ->
    uri = new URI(uri)
    queryParams = uri.query(true)

    equal = true

    for key, value of params
      # compare as strings to avoid string to float compare hijinx
      unless queryParams[key]? && (queryParams[key].toString() == params[key].toString())
        equal = false

    equal

  ###
  Helper function that takes a uri and replaces the query parameters, any existing query
  parameters that exist and not mentioned in the params hash will be left alone
  @param URI|string of url to update
  @param hash of query parameters that will be replaced
  @returns URI updated uri object
  ###
  @replaceQuery: (uri, params) ->
    uri = new URI(uri)

    for key, value of params
      if uri.hasQuery(key)
        uri.removeQuery(key)

    uri.addQuery(params)
