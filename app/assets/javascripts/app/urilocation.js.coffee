root = exports ? this # root and window are same thing in browser
root.App ?= {}
$ = jQuery

class App.URILocation

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
