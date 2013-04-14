module XES
  # FormatError is raised when you failed to format XES element.
  class FormatError < StandardError
    # @param element [Object]
    #   object that caused to raise this exception
    def initialize(element)
      @element = element
    end

    # @api private
    def message
      "Error happened on formatting %s" % @element
    end
  end
end
