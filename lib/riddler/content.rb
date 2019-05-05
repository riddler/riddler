module Riddler
  class Content
    def initialize definition, context
      @definition = definition
      @context = context
    end

    def content_type
      self.class::CONTENT_TYPE
    end

    def type
      self.class::TYPE
    end

    def id
      definition["id"]
    end

    def journey
      @journey = context["journey"]
    end

    def each &block
      ::Riddler::Visitors::Each.new(block).accept self
    end

    def enter
      debug "enter", content_type: content_type, id: id, journey_id: journey.id
      ::Riddler::Messaging.producer.publish "enter", {id: id, journey_id: journey.id}
    end
  end
end
