module XES
  # Attribute represents attribute of XES.
  class Attribute
    extend AttributeAccessor

    # @!attribute [rw] semantic_modelReference
    #   @return [String]
    #     the value of meta attribute "semantic:modelReference"
    define_attribute "semantic:modelReference", "string"

    # @!attribute [rw] identity_id
    #   @return [String]
    #     the value of meta attribute "identity:id"
    define_attribute "identity:id", "id"

    # @!attribute [rw] cost_amount
    #   @return [Float]
    #     the value of meta attribute "cost:amount"
    define_attribute "cost:amount", "float"

    # @!attribute [rw] cost_driver
    #   @return [String]
    #     the value of meta attribute "cost:driver"
    define_attribute "cost:driver", "string"

    # @!attribute [rw] cost_type
    #   @return [String]
    #     the value of meta attribute "cost:type"
    define_attribute "cost:type", "string"

    # @return [String]
    #   attribute type
    attr_reader :type

    # @return [String]
    #   attribute name
    attr_accessor :key

    # @return [String]
    #   attribute value
    attr_accessor :value

    # @return [Meta]
    #   attribute meta attributes
    attr_accessor :meta

    # @param type [String]
    #   attribute type
    # @param key [String]
    #   attribute name
    # @param value [String]
    #   attribute value
    # @param meta [Array<Attribute>]
    #   meta attributes
    def initialize(type, key, value, meta=[])
      @type = type
      @key = key
      @value = value
      @meta = meta
    end

    # Return true if the element is formattable.
    #
    # @return [Boolean]
    #   true if the element is formattable
    def formattable?
      not(@type.nil? or @key.nil? or @value.nil? or @meta.nil?)
    end

    # Format as a XML element.
    def format
      raise FormatError.new(self) unless formattable?

      REXML::Element.new(type).tap do |attribute|
        attribute.attributes["key"] = @key
        attribute.attributes["value"] = format_value
        meta.each {|m| attribute.elements << m.format if m.formattable?}
      end
    end

    # @api private
    def ==(other)
      return false unless other.kind_of?(self.class)
      @type == other.type and @key == other.key and @value == other.value and @meta == other.meta
    end
    alias :eql? :"=="

    # @api private
    def hash
      @type.hash + @key.hash + @value.hash
    end

    private

    # Format the value.
    #
    # @return [String]
    def format_value
      case @type
      when "string"
        @value
      when "date"
        @value.kind_of?(Time) ? @value.iso8601 : @value
      when "int"
        @value.kind_of?(Integer) ? @value : @value.to_i
      when "float"
        @value.kind_of?(Float) ? @value : @value.to_f
      when "boolean"
        @value
      when "id"
        @value
      end.to_s
    end
  end

  class << self
    # Return string attribute object.
    #
    # @param key [String]
    #   attribute name
    # @param value [Object]
    #   attribute value
    # @param meta [Array<Attribute>]
    #   meta attributes
    # @return [Attribute]
    #   string attribute
    def string(key, value, meta=[])
      Attribute.new("string", key, value, meta)
    end

    # Return date attribute object.
    #
    # @param key [String]
    #   attribute name
    # @param value [Object]
    #   attribute value
    # @param meta [Array<Attribute>]
    #   meta attributes
    # @return [Attribute]
    #   date attribute
    def date(key, value, meta=[])
      Attribute.new("date", key, value, meta)
    end

    # Return int attribute object.
    #
    # @param key [String]
    #   attribute name
    # @param value [Object]
    #   attribute value
    # @param meta [Array<Attribute>]
    #   meta attributes
    # @return [Attribute]
    #   int attribute
    def int(key, value, meta=[])
      Attribute.new("int", key, value, meta)
    end

    # Return float attribute object.
    #
    # @param key [String]
    #   attribute name
    # @param value [Object]
    #   attribute value
    # @param meta [Array<Attribute>]
    #   meta attributes
    # @return [Attribute]
    #   float attribute
    def float(key, value, meta=[])
      Attribute.new("float", key, value, meta)
    end

    # Return boolean attribute object.
    #
    # @param key [String]
    #   attribute name
    # @param value [Object]
    #   attribute value
    # @param meta [Array<Attribute>]
    #   meta attributes
    # @return [Attribute]
    #   boolean attribute
    def boolean(key, value, meta=[])
      Attribute.new("boolean", key, value, meta)
    end

    # Return id attribute object.
    #
    # @param key [String]
    #   attribute name
    # @param value [Object]
    #   attribute value
    # @param meta [Array<Attribute>]
    #   meta attributes
    # @return [Attribute]
    #   id attribute
    def id(key, value, meta=[])
      Attribute.new("id", key, value, meta)
    end
  end
end
