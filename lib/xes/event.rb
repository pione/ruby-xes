module XES
  # XESEvent represents "event" element of XES.
  class Event
    include EventAttributeAccessor

    # @return [Array<Attribute>]
    #   event attributes
    attr_accessor :attributes

    # Create a XES event.
    #
    # @param attributes [Array<Attribute>]
    #   attributes of the event
    def initialize(attributes=[])
      @attributes = attributes
    end

    # Return true if the element is formattable.
    #
    # @return [Boolean]
    #   true if the element is formattable
    def formattable?
      not(@attributes.empty?)
    end

    # Format as a XML element.
    #
    # @return [REXML::Element]
    #   XML element
    def format
      REXML::Element.new("event").tap do |event|
        @attributes.each do |attribute|
          event.elements << attribute.format if attribute.formattable?
        end
      end
    end

    # @api private
    def ==(other)
      return false unless other.kind_of?(self.class)
      @attributes == other.attributes
    end
    alias :eql? :"=="

    # @api private
    def hash
      @attributes.hash
    end
  end
end
