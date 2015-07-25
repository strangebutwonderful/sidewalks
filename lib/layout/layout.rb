###
# Layout helpers and variables
###
module Layout
  def footer?
    return @footer unless @footer.nil?

    @footer ||= true
  end

  def disable_footer
    @footer = false
  end

  def self.included(method)
    return unless method < ActionController::Base
    method.helper_method :footer?
  end
end
