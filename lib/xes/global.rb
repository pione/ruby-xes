module XES
  # Global represents "global" element of XES.
  class Global
    class << self
      # Create an event global. The object extended by EventAttributeAccessor.
      #
      # @param attributes [Array<Attribute>]
      #   event global attributes
      def event(attributes=[])
        new("event", attributes).tap do |global|
          global.extend EventAttributeAccessor
        end
      end

      # Create a trace global. The object extended by TraceAttributeAccessor.
      #
      # @param attributes [Array<Attribute>]
      #   trace global attributes
      def trace(attributes=[])
        new("trace", attributes).tap do |global|
          global.extend TraceAttributeAccessor
        end
      end
    end

    # @return [String]
    #   scope name
    attr_reader :scope

    # @return [Array<Attribute>]
    #   global attributes
    attr_accessor :attributes

    # @param scope [String]
    #   scope of global attributes
    # @param attributes [Arrray<Attribute>]
    #   global attributes
    def initialize(scope, attributes=[])
      @scope = scope
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
      raise FormatError.new(self) unless formattable?

      REXML::Element.new("global").tap do |global|
        global.attributes["scope"] = @scope.to_s
        @attributes.each {|attribute| global.elements << attribute.format}
      end
    end

    # @api private
    def ==(other)
      @scope == other.scope and @attributes == other.attributes
    end
    alias :eql? :"=="

    # @api private
    def hash
      @scope.hash + @attributes.hash
    end
  end
end
