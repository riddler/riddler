module Riddler
  module UseCases

    class PreviewStep
      attr_reader :definition, :params, :headers, :step

      def initialize definition, params: {}, headers: {}
        @definition = definition
        @params = params
        @headers = headers
        @step = ::Riddler::Step.for definition, context
      end

      def context
        @context ||= begin
          director = ::Riddler::ContextDirector.new params: params,
            headers: headers
          director.context
        end
      end

      def process
        step.to_hash
      end
    end

  end
end
