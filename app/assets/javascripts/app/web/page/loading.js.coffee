AJAX_LOADING_CLASS = "ajax-loading"

$(document).ajaxStart ->
  $("body").addClass AJAX_LOADING_CLASS
  console.log "ajaxStart"
  return true

$(document).ajaxStop ->
  $("body").removeClass AJAX_LOADING_CLASS
  console.log "ajaxStop"
  return true
