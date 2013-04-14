module XES
  # Trace represents "trace" element of XES.
  class Trace
    include TraceAttributeAccessor

    # @return [Array<Attribute>]
    #  attributes of the trace element
    attr_accessor :attributes

    # @return [Array<Event>]
    #  events included in the trace element
    attr_accessor :events

    # Create a XES trace.
    #
    # @param events [Array<Event>]
    #   events included in the trace element
    def initialize(attributes=[], events=[])
      @attributes = attributes
      @events = events
    end

    # Return true if the element is formattable.
    #
    # @return [Boolean]
    #   true if the element is formattable
    def formattable?
      @events.any? {|event| event.formattable?}
    end

    # Format as a XML element.
    #
    # @return [REXML::Element]
    #   XML element
    # @raise FormatError
    def format
      raise FormatError.new(self) unless formattable?

      REXML::Element.new("trace").tap do |trace|
        @attributes.each {|attribute| trace.elements << attribute.format if attribute.formattable?}
        @events.each {|event| trace.elements << event.format if event.formattable?}
      end
    end

    # @api private
    def ==(other)
      return false unless other.kind_of?(self.class)
      @attributes == other.attributes and @events == other.events
    end
    alias :eql? :"=="

    # @api private
    def hash
      @attributes.hash + @events.hash
    end
  end
end
