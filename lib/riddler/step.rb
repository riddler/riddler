module Riddler
  class Step < ::Riddler::Content
    CONTENT_TYPE = "step".freeze

    attr_reader :definition, :context

    def self.subclasses
      @@subclasses ||= []
    end

    def self.inherited subclass
      self.subclasses << subclass
    end

    def self.for definition, context
      step_type = definition["type"]

      klass = subclasses.detect { |k| k.type == step_type }
      raise "Unknown step type '#{step_type}'" if klass.nil?

      klass.new definition, context
    end

    def to_hash
      {
        content_type: content_type,
        type: type,
        id: definition["id"],
        name: definition["name"]
      }
    end
  end
end

require_relative "steps/content"
require_relative "steps/flow"
require_relative "steps/input"
require_relative "steps/variant"
