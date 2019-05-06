module Riddler
  class Content
    include ::Riddler::Concerns::Includeable
    include ::Riddler::Concerns::Logging

    def self.content_type
      self::CONTENT_TYPE
    end

    def self.type
      self::TYPE
    end

    def self.from_definition definition, context={}
      context = ::Riddler::Context.new_from context
      case definition["content_type"].to_s.downcase
      when "element"
        ::Riddler::Element.for definition, context
      when "step"
        ::Riddler::Step.for definition, context
      end
    end

    def initialize definition, context
      @definition = definition
      @context = context
    end

    def container
      definition["container"]
    end

    def container_location
      container&.location
    end

    def content_type
      self.class.content_type
    end

    def id
      definition["id"]
    end

    def journey
      @journey = context["journey"]
    end

    def name
      definition["name"]
    end

    def type
      self.class.type
    end

    # Visitors

    def each &block
      ::Riddler::Visitors::Each.new(block).accept self
    end

    def to_dot
      ::Riddler::Visitors::Dot.new.accept self
    end

    def enter
      debug "enter", content_type: content_type, id: id, journey_id: journey.id
      ::Riddler::Messaging.producer.publish "enter", {id: id, journey_id: journey.id}
    end
  end
end
