module Riddler
  class Context
    attr_reader :variables

    def initialize input = nil
      input ||= {}
      @variables = {
        "ids" => {}
      }
      input.each do |key, value|
        next if value.nil?
        assign key, value
      end
    end

    def assign name, value
      variables[name.to_s] = drop_for value
    end

    def variable name
      variables[name.to_s]
    end

    def render string
      template = ::Liquid::Template.parse string
      template.render variables
    end

    def add_id name, value
      variables["ids"][name.to_s] = value
    end

    def to_liquid
      Liquid::Context.new [variables]
    end

    def to_hash
      hash_array = variables.map do |key, value|
        [key, hash_value(value)]
      end
      Hash[hash_array]
    end

    def method_missing method_name, *_args
      return super unless variables.key? method_name.to_s
      variable method_name
    end

    private

    def drop_for data
      case data
      when ::Liquid::Drop
        data
      when ::Hash
        ::Riddler::Drops::HashDrop.new data
      else
        data
      end
    end

    def hash_value value
      return value.to_hash if value.respond_to? :to_hash
      value
    end
  end
end
