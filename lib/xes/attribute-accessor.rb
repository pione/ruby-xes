module XES
  # AttributeAccessor provides attribute accessors of standard extensions.
  module AttributeAccessor
    # Define an attribute accessor.
    #
    # @param name [String]
    #   attribute name
    # @param type [String]
    #   attribute type
    # @return [void]
    def define_attribute(name, type)
      _name = name.gsub(":", "_")

      define_method(_name) do
        var = instance_variables.include?(:@meta) ? :@meta : :@attributes
        instance_variable_get(var).find do |attribute|
          attribute.key == name
        end.tap{|x| return x.value if x}
      end

      define_method("%s=" % _name) do |value|
        var = instance_variables.include?(:@meta) ? :@meta : :@attributes
        instance_variable_get(var).tap do |attributes|
          if elt = __send__(_name)
            attributes.delete(elt)
          end
          attributes << XES.send(type, name, value)
        end
      end
    end
  end

  # EventAttributeAccessor provides attribute accessors for event or event global element.
  module EventAttributeAccessor
    extend AttributeAccessor

    # @!attribute [rw] concept_name
    #   @return [String]
    #     the value of attribute "concept:name"
    define_attribute "concept:name", "string"

    # @!attribute [rw] concept_instance
    #   @return [String]
    #     the value of attribute "concept:instance"
    define_attribute "concept:instance", "string"

    # @!attribute [rw] lifecycle_transition
    #   @return [String]
    #     the value of attribute "lifecycle:transition"
    define_attribute "lifecycle:transition", "string"

    # @!attribute [rw] org_resource
    #   @return [String]
    #     the value of attribute "org:resource"
    define_attribute "org:resource", "string"

    # @!attribute [rw] org_role
    #   @return [String]
    #     the value of attribute "org:role"
    define_attribute "org:role", "string"

    # @!attribute [rw] org_group
    #   @return [String]
    #     the value of attribute "org:group"
    define_attribute "org:group", "string"

    # @!attribute [rw] time_timestamp
    #   @return [Time,String]
    #     the value of attribute "time:timestamp"
    define_attribute "time:timestamp", "date"

    # @!attribute [rw] semantic_modelReference
    #   @return [String]
    #     the value of attribute "semantic:modelReference"
    define_attribute "semantic:modelReference", "string"

    # @!attribute [rw] identity_id
    #   @return [String]
    #     the value of attribute "identity:id"
    define_attribute "identity:id", "id"

    # @!attribute [rw] cost_total
    #   @return [Float]
    #     the value of attribute "cost:total"
    define_attribute "cost:total", "float"

    # @!attribute [rw] cost_currency
    #   @return [String]
    #     the value of attribute "cost:currency"
    define_attribute "cost:currency", "string"
  end

  # TraceAttributeAccessor provides attribute accessors for trace or trace global element.
  module TraceAttributeAccessor
    extend AttributeAccessor
    # @!attribute [rw] concept_name
    #   @return [String]
    #     the value of attribute "concept:name"
    define_attribute "concept:name", "string"

    # @!attribute [rw] semantic_modelReference
    #   @return [String]
    #     the value of attribute "semantic:modelReference"
    define_attribute "semantic:modelReference", "string"

    # @!attribute [rw] identity_id
    #   @return [String]
    #     the value of attribute "identity:id"
    define_attribute "identity:id", "id"

    # @!attribute [rw] cost:total
    #   @return [Float]
    #     the value of attribute "cost:total"
    define_attribute "cost:total", "float"

    # @!attribute [rw] cost_currency
    #   @return [String]
    #     the value of attribute "cost:currency"
    define_attribute "cost:currency", "string"
  end
end
