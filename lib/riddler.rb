require "riddler/version"

require "faraday"
require "faraday_middleware"
require "liquid"
require "outlog"
require "predicator"
require "ulid"

require "riddler/includeable"

require "riddler/drops/hash_drop"

require "riddler/configuration"

require "riddler/context_builder"
require "riddler/context_builders/cookies"
require "riddler/context_builders/faraday_builder"
require "riddler/context_builders/preferred_language"
require "riddler/context_director"
require "riddler/context"

require "riddler/element"
require "riddler/elements/heading"
require "riddler/elements/image"
require "riddler/elements/link"
require "riddler/elements/text"
require "riddler/elements/variant"

require "riddler/step"
require "riddler/steps/content"
require "riddler/steps/variant"

require "riddler/use_cases"

# Emails
require "inky"
require "premailer"
require "riddler/email"
require "riddler/emails/basic"
require "riddler/emails/variant"

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

  def self.render content_definition, context={}
    unless context.kind_of? ::Riddler::Context
      director = ::Riddler::ContextDirector.new context
      context = director.context
    end

    case content_definition["content_type"]
    when "element"
      content = ::Riddler::Element.for content_definition, context
    when "email"
      content = ::Riddler::Email.for content_definition, context
    when "step"
      content = ::Riddler::Step.for content_definition, context
    end

    return nil unless content.include?

    content.to_hash
  end
end
