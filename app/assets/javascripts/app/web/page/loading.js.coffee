AJAX_LOADING_CLASS = "ajax-loading"

$(document).ajaxStart ->
  $("body").addClass AJAX_LOADING_CLASS
  App.Logger.debug.log "ajaxStart"
  return true

$(document).ajaxStop ->
  $("body").removeClass AJAX_LOADING_CLASS
  console.log "ajaxStop"
  return true

$ ->
  bar = new Nanobar({
    bg: "#00354F",
    target: $(".nanobar")[0]
  })

  $(document).on 'click', 'a', ->
    bar.go 100
    return true
