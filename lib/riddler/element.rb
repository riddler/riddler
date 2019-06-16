module Riddler
  class Element < ::Riddler::Content
    CONTENT_TYPE = "Element".freeze

    attr_reader :definition, :context

    def self.subclasses
      @@subclasses ||= []
    end

    def self.inherited subclass
      self.subclasses << subclass
    end

    def self.for definition, context
      element_type = definition["type"]

      # Maybe this should be a registry
      klass = subclasses.detect { |k| k.type == element_type }
      raise "Unknown element type '#{element_type}'" if klass.nil?

      klass.new definition, context
    end

    def initialize definition, context
      @definition = definition
      @context = context
    end

    def to_hash
      {
        content_type: content_type,
        type: self.class.type,
        id: definition["id"],
        name: definition["name"]
      }
    end
  end
end

require "riddler/elements/button"
require "riddler/elements/heading"
require "riddler/elements/image"
require "riddler/elements/link"
require "riddler/elements/text"
require "riddler/elements/variant"

require "riddler/elements/text_question"
