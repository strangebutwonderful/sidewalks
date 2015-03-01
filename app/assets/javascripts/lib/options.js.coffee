#= require ./lib

class Lib.Options

  ###
  # Load options from an element
  # @param
  ###
  @load: (optionNames, element, prefix = "") =>
    $element = $(element)

    options = {}

    for optionName in optionNames
      optionValue = $element.data(prefix + optionName.toLowerCase())
      options[optionName] = optionValue if optionValue?

    options
