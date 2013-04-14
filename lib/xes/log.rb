module XES
  # Log represents log element of XES.
  class Log
    extend AttributeAccessor

    # @!attribute [rw] concept_name
    #   @return [String]
    #     the value of attribute "concept:name"
    define_attribute "concept:name", "string"

    # @!attribute [rw] lifecycle_model
    #   @return [String]
    #     the value of attribute "lifecycle:model"
    define_attribute "lifecycle:model", "string"

    # @!attribute [rw] semantic_modelReference
    #   @return [String]
    #     the value of attribute "semantic:modelReference"
    define_attribute "semantic:modelReference", "string"

    # @!attribute [rw] identity_id
    #   @return [String]
    #     the value of attribute "identity:id"
    define_attribute "identity:id", "id"

    class << self
      # Create new instance with default values.
      #
      # @return [Log]
      #   new log instance
      def default
        new.tap do |log|
          log.xes_version = "1.4"
          log.xes_features = "nested-attributes"
          log.openxes_version = "1.0RC7"
          log.extensions = [
            EXTENSION[:concept],
            EXTENSION[:identity],
            EXTENSION[:time],
            EXTENSION[:lifecycle],
            EXTENSION[:organizational],
          ]
          log.classifiers = [
            CLASSIFIER[:mxml_legacy_classifier],
            CLASSIFIER[:event_name],
            CLASSIFIER[:resource]
          ]
        end
      end
    end

    # @return [String]
    #   XES version
    attr_accessor :xes_version

    # @return [String]
    #   XES features
    attr_accessor :xes_features

    # @return [String]
    #   openxes version for faking ProM
    attr_accessor :openxes_version

    # @return [String]
    #   xmlns value
    attr_accessor :xmlns

    # @return [Array<Extension>]
    #   XES extensions
    attr_accessor :extensions

    # @return [Array<Classifier>]
    #   XES classifiers
    attr_accessor :classifiers

    # @return [Array<Global>]
    #   XES global elements for event attributes
    attr_accessor :event_global

    # @return [Array<Global>]
    #   XES global elements for trace attributes
    attr_accessor :trace_global

    # @return [Array<Attribute>]
    #   XES attribute elements
    attr_accessor :attributes

    # @return [Array<XESTrace>]
    #   XES trace elements
    attr_accessor :traces

    def initialize
      @xes_version = "1.4"
      @xes_features = ""
      @openxes_version = nil
      @xmlns = "http://www.xes-standard.org/"
      @extensions = []
      @event_global = Global.event
      @trace_global = Global.trace
      @classifiers = []
      @attributes = []
      @traces = []
    end

    # Return true if the element is formattable.
    #
    # @return [Boolean]
    #   true if the element is formattable
    def formattable?
      @traces.any? {|trace| trace.formattable?}
    end

    # Format as a XML element.
    #
    # @return [REXML::Element]
    #   XML element
    # @raise FormatError
    #   format error when the log is formattable
    def format
      raise FormatError.new(self) unless formattable?

      REXML::Element.new("log").tap do |log|
        log.attributes["xes.version"] = @xes_version.to_s if @xes_version
        log.attributes["xes.features"] = @xes_features.to_s if @xes_features
        log.attributes["openxes.version"] = @openxes_version.to_s if @openxes_version
        log.attributes["xmlns"] = @xmlns.to_s if @xmlns
        @extensions.each {|ext| log.elements << ext.format if ext.formattable?}
        @classifiers.each {|classifier| log.elements << classifier.format if classifier.formattable?}
        log.elements << @event_global.format if @event_global.formattable?
        log.elements << @trace_global.format if @trace_global.formattable?
        @attributes.each {|attribute| log.elements << attribute.format if attribute.formattable?}
        @traces.each {|trace| log.elements << trace.format if trace.formattable?}
      end
    end

    # @api private
    def ==(other)
      return false unless other.kind_of?(self.class)
      return false unless @xes_version == other.xes_version
      return false unless @xes_features == other.xes_features
      return false unless @openxes_version == other.openxes_version
      return false unless @xmlns == other.xmlns
      return false unless @extensions == other.extensions
      return false unless @event_global == other.event_global
      return false unless @trace_global == other.trace_global
      return false unless @classifiers == other.classifiers
      return false unless @attributes == other.attributes
      return false unless @traces == other.traces
      return true
    end
    alias :eql? :"=="

    # @api private
    def hash
      @attributes.hash + @events.hash
    end
  end
end
