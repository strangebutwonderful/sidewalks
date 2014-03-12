#= require ./lib

class Lib.Options

  ###
  # Load options from an element
  # @param 
  ###
  @load: (options, element, prefix = "") =>
    $element = $(element)
    
    for optionName in options
      optionValue = $element.data(prefix + optionName.toLowerCase())
      options[optionName] = optionValue if optionValue?

    options
