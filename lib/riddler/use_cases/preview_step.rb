module Riddler
  module UseCases

    class PreviewStep
      attr_reader :definition, :context, :step

      def initialize definition, context = ::Riddler::Context.new
        @definition = definition
        @context = context
        @step = ::Riddler::Step.for definition, context
      end

      def process
        step.to_hash
      end
    end

  end
end
