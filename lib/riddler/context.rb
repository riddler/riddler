module Riddler

  class Context
    attr_reader :variables

    def initialize input = nil
      input ||= {}
      @variables = {}
      input.each do |key, value|
        assign key, drop_for(value)
      end
    end

    def assign name, value
      variables[name.to_s] = value
    end

    def variable name
      variables[name.to_s]
    end

    def render string
      template = ::Liquid::Template.parse string
      template.render variables
    end

    def method_missing method_name, *_args
      return super unless variables.key? method_name.to_s
      variable method_name
    end

    private

    def drop_for data
      ::Riddler::Drops::HashDrop.new data
    end
  end

end
