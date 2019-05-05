module Riddler
  class Step < ::Riddler::Content
    CONTENT_TYPE = "step".freeze

    include ::Riddler::Concerns::Includeable
    include ::Riddler::Concerns::Logging

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
