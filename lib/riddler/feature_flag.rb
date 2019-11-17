module Riddler
  class FeatureFlag
    include ::Riddler::Concerns::Includeable
    include ::Riddler::Concerns::Logging

    attr_reader :definition, :context

    def self.type
      self::TYPE
    end

    def self.subclasses
      @@subclasses ||= []
    end

    def self.inherited subclass
      self.subclasses << subclass
    end

    def self.for definition, context
      feature_flag_type = definition["type"]

      klass = subclasses.detect { |k| k.type == feature_flag_type }
      raise "Unknown feature_flag type '#{feature_flag_type}'" if klass.nil?

      klass.new definition, context
    end

    def initialize definition, context
      @definition = definition
      @context = context
    end

    def name
      definition["name"]
    end

    def type
      self.class.type
    end

    def to_hash
      {
        type: type,
        id: definition["id"],
        name: definition["name"]
      }
    end
  end
end

require_relative "feature_flags/segment"
