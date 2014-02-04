hrefSelector = '[data-href]';

$ -> 
  $(hrefSelector).click ->
    window.location = $(this).data('href')

# Prevent link children from populating the click event up to the parent clickable
$ ->
  $(hrefSelector).find('a').click (e) ->
    e.stopPropagation();