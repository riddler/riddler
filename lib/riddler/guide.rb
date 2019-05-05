module Riddler
  class Guide
    attr_reader :content_definition, :context, :journey

    def initialize content_definition, context = nil
      @content_definition = normalize_definition content_definition
      @context = normalize_context context
      @journey = find_or_create_journey
    end

    def content
      @content ||= \
        case content_definition["content_type"].to_s.downcase
        when "element"
          ::Riddler::Element.for content_definition, context
        when "step"
          ::Riddler::Step.for content_definition, context
        end
    end

    def find_or_create_journey
      journey = ::Riddler::Journey.new
      journey_drop = ::Riddler::Drops::JourneyDrop.new journey
      context.assign "journey", journey_drop

      journey
    end

    def process
      return nil unless content.include?
      content.enter
      content.to_hash
    end

    private

    def normalize_context context = nil
      context = ::Riddler::Context.new if context.nil?

      unless context.kind_of? ::Riddler::Context
        director = ::Riddler::ContextDirector.new context
        context = director.context
      end

      context
    end

    def normalize_definition definition
      definition&.transform_keys! { |k| k.to_s }
    end
  end
end
