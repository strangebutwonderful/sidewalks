root = exports ? this # root and window are same thing in browser
root.App ?= {}
$ = jQuery

class App.Browser

  ### 
  Smoothly scroll the browser to the given element
  @example App.Browser.scrollTo("#myDiv")
  @example App.Browser.scrollTo($jQueryObj)
  @param target selector|jQuery Object to scroll to
  ### 
  @scrollTo: (target) ->
    $target = $(target)
    if($target.length)
      $("html, body").animate # body required for older browsers -_-
        scrollTop: $target.offset().top
      , 1000