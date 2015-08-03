###
# Layout helpers and variables
###
module Layout
  extend ActiveSupport::Concern
  included do
    helper_method :footer?
  end

  def footer?
    return @footer unless @footer.nil?

    @footer ||= true
  end

  def disable_footer
    @footer = false
  end
end
