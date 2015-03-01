# ajaxLoadingClass = "ajax-loading"

# $(document).ajaxStart ->
#   $("body").addClass ajaxLoadingClass
#   console.log "ajaxStart"
#   return

# $(document).ajaxStop ->
#   $("body").removeClass ajaxLoadingClass
#   console.log "ajaxStop"
#   return

$ ->
  bar = new Nanobar({
    bg: "#4fb53c",
    target: $(".nanobar")[0]
  })

  $(document).on 'click', 'a', ->
    bar.go 100
    return true
