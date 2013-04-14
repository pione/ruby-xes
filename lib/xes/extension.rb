module XES
  # Extension represents "extension" element of XES.
  class Extension
    # @return [String]
    #   extension name
    attr_reader :name

    # @return [String]
    #   extension prefix
    attr_reader :prefix

    # @return [String]
    #   extension URI
    attr_reader :uri

    # Create a XES extension element.
    #
    # @param name [String]
    #   extension name
    # @param prefix [String]
    #   extension prefix
    # @param uri [String]
    #   extension definition URI
    def initialize(name, prefix, uri)
      @name = name
      @prefix = prefix
      @uri = uri
    end

    # Return true if the element is formattable.
    #
    # @return [Boolean]
    #   true if the element is formattable
    def formattable?
      not(@name.nil? or @prefix.nil? or @uri.nil?)
    end

    # Format as a XML element.
    #
    # @return [REXML::Element]
    #   XML element
    def format
      raise FormatError.new(self) unless formattable?

      REXML::Element.new("extension").tap do |ext|
        ext.attributes["name"] = @name
        ext.attributes["prefix"] = @prefix
        ext.attributes["uri"] = @uri
      end
    end

    # @api private
    def ==(other)
      return false unless other.kind_of?(self.class)
      @name == other.name and @prefix == other.prefix and @uri == other.uri
    end
    alias :eql? :"=="

    # @api private
    def hash
      @name.hash + @prefix.hash + @uri.hash
    end
  end

  # known XES extension elements
  EXTENSION = {
    :concept => Extension.new("Concept", "concept", "http://www.xes-standard.org/concept.xesext"),
    :identity => Extension.new("Identity", "identity", "http://www.xes-standard.org/identity.xesext"),
    :time => Extension.new("Time", "time", "http://www.xes-standard.org/time.xesext"),
    :lifecycle => Extension.new("Lifecycle", "lifecycle", "http://www.xes-standard.org/lifecycle.xesext"),
    :organizational => Extension.new("Organizational", "org", "http://www.xes-standard.org/org.xesext")
  }
end
