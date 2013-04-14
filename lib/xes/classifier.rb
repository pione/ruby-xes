module XES
  # Classifier represents "classifier" element of XES.
  class Classifier
    # @return [String]
    #   classifier name
    attr_reader :name

    # @return [String]
    #   classifier keys
    attr_reader :keys

    # Create a XES classifier element.
    #
    # @param name [String]
    #   classifier name
    # @param keys [String]
    #   classifier keys
    def initialize(name, keys)
      @name = name
      @keys = keys
    end

    # Return true if the element is formattable.
    #
    # @return [Boolean]
    #   true if the element is formattable
    def formattable?
      not(@name.nil? or @keys.nil?)
    end

    # Format as a XML element.
    #
    # @return [REXML::Element]
    #   XML element
    def format
      raise FormatError.new(self) unless formattable?

      REXML::Element.new("classifier").tap do |ext|
        ext.attributes["name"] = @name
        ext.attributes["keys"] = @keys
      end
    end

    # @api private
    def ==(other)
      return false unless other.kind_of?(self.class)
      @name == other.name and @keys == other.keys
    end
    alias :eql? :"=="

    # @api private
    def hash
      @name.hash + @keys.hash
    end
  end

  # known XES classifier elements
  CLASSIFIER = {
    :mxml_legacy_classifier => Classifier.new("MXML Legacy Classifier", "concept:name lifecycle:transition"),
    :event_name => Classifier.new("Event Name", "concept:name"),
    :resource => Classifier.new("Resource", "org:resource")
  }
end
