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

    #def initialize definition, context
    #  @definition = definition
    #  @context = context
    #end

    #def id
    #  definition["id"]
    #end

    #def journey
    #  @journey = context["journey"]
    #end

    #def enter
    #  debug "enter", content_type: CONTENT_TYPE, id: id, journey_id: journey.id
    #  ::Riddler::Messaging.producer.publish "enter", {id: id, journey_id: journey.id}
    #end

    def to_hash
      {
        content_type: CONTENT_TYPE,
        type: self.class.type,
        id: definition["id"],
        name: definition["name"]
      }
    end
  end
end
