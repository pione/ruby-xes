module XES
  # Document is a class for XES event log doucment.
  class Document
    # @return [Log]
    #   log element
    attr_accessor :log

    # @param log [Log]
    def initialize(log=nil)
      @log = log
    end

    # Return true if the document is formattable.
    #
    # @return [Boolean]
    #   true if the element is formattable
    def formattable?
      not(@log.nil?)
    end

    # Format as a XML document.
    #
    # @return [REXML::Document]
    #   XML document
    # @raise FormatError
    #   format error when the document is not formattable
    def format
      raise FormatError.new(self) unless formattable?

      REXML::Document.new.tap do |doc|
        doc << REXML::XMLDecl.new
        doc.elements << @log.format
      end
    end

    # @api private
    def ==(other)
      return false unless other.kind_of?(self.class)
      @log == other.log
    end
    alias :eql? :"=="

    # @api private
    def hash
      @attributes.hash + @events.hash
    end
  end
end
