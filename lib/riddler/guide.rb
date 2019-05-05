module Riddler
  class Guide
    attr_reader :content_definition, :journey

    def initialize content_definition
      @content_definition = normalize_definition content_definition
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

      #  slug_name: slug.name,
      #  slug_id: slug.id,
      #  status: "ACTIVE",
      #  content_definition_id: slug.content_definition_id,
      #  identifiers: context.ids

      #@interaction.identity = identity if request_is_unique?

      #interaction_repo.create interaction
    end

    def process
      return nil unless content.include?
      content.enter
      content.to_hash
      #::Riddler::Messaging.producer.publish "foo", "bar"
    #return nil unless content.include?

    #content.to_hash
    end


    #def initialize content_definition_repo:, content_definition_id:, context_director:
    #  @content_definition_repo = content_definition_repo
    #  @content_definition_id = content_definition_id
    #  @context_director = context_director

    #  @content_definition = lookup_content_definition
    #  @step = ::Riddler::Step.for content_definition.definition, context
    #end

    def context
      @context ||= ::Riddler::Context.new
    end

    #def process
    #  step.to_hash
    #end

    #def excluded?
    #  !step.include?
    #end

    private

    #def generate_context
    #  director = ::Riddler::ContextDirector.new params: params,
    #    headers: headers
    #  director.context
    #end

    #def lookup_content_definition
    #  content_definition_repo.find_by id: content_definition_id
    #end

    def normalize_definition definition
      definition&.transform_keys! { |k| k.to_s }
    end
  end
end
