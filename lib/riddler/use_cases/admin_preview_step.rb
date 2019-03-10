module Riddler
  module UseCases
    class AdminPreviewStep
      attr_reader :definition, :preview_context_data, :context, :step

      def initialize definition, preview_context_data: {}
        @definition = definition
        @preview_context_data = preview_context_data
        @context = ::Riddler::Context.new preview_context_data
        @step = ::Riddler::Step.for definition, context
      end

      def process
        if step.include?
          hash = step.to_hash
          return hash unless hash.nil?

          {
            response_code: 204,
            message: "There was no step to include"
          }
        else
          {
            response_code: 204,
            include_predicate: step.include_predicate,
            message: "Excluded - the include_predicate returned false"
          }
        end
      end
    end
  end
end
