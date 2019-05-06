module Riddler
  class Guide
    attr_reader :content_definition, :context, :journey

    def initialize content_definition, context = nil
      @content_definition = normalize_definition content_definition
      @context = ::Riddler::Context.new_from context
      @journey = find_or_create_journey
    end

    def content
      @content ||= ::Riddler::Content.from_definition content_definition, context
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

    def next_step
      ::Riddler::Visitors::NextStep.new(journey, context).accept content
    end

    private

    def normalize_definition definition
      definition&.transform_keys! { |k| k.to_s }
    end
  end
end
