require "riddler/version"

require "faraday"
require "faraday_middleware"
require "liquid"
require "outlog"
require "predicator"
require "ulid"

require "riddler/concerns"

require "riddler/drops/hash_drop"
require "riddler/drops/journey_drop"

require "riddler/action"

require "riddler/configuration"

require "riddler/content"

require "riddler/context_builder"
require "riddler/context_builders/faraday_builder"
require "riddler/context_builders/preferred_language"
require "riddler/context_director"
require "riddler/context"

require "riddler/element"

require "riddler/guide"
require "riddler/journey"
require "riddler/location"
require "riddler/messaging"

require "riddler/step"

require "riddler/use_cases"

require "riddler/visitor"

module Riddler
  class Error < StandardError; end

  def self.configure
    yield configuration
  end

  def self.configuration
    @configuration ||= ::Riddler::Configuration.new
  end

  def self.config; configuration; end

  def self.logger
    @logger ||= ::Outlog.logger
  end

  def self.content_for content_definition, context={}
    guide = ::Riddler::Guide.new content_definition, context
    guide.content
  end

  def self.render content_definition, context={}
    unless context.kind_of? ::Riddler::Context
      director = ::Riddler::ContextDirector.new context
      context = director.context
    end

    case content_definition["content_type"]
    when "Element"
      content = ::Riddler::Element.for content_definition, context
    when "Step"
      content = ::Riddler::Step.for content_definition, context
    end

    return nil unless content.include?

    content.to_hash
  end
end
