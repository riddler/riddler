module Riddler

  class Context
    attr_reader :variables

    def initialize input = nil
      input ||= {}
      @variables = {}
      input.each do |key, value|
        assign key, value
      end
    end

    def assign name, value
      variables[name.to_s] = value
    end

    def render string
      template = ::Liquid::Template.parse string
      template.render variables
    end
  end

end
