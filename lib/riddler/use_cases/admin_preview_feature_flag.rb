module Riddler
  module UseCases
    class AdminPreviewFeatureFlag
      attr_reader :definition, :preview_context_data, :context, :feature_flag

      def initialize definition, preview_context_data: {}
        @definition = definition
        @preview_context_data = preview_context_data
        @context = ::Riddler::Context.new preview_context_data
        @feature_flag = ::Riddler::FeatureFlag.for definition, context
      end

      def process
        if feature_flag.include?
          hash = feature_flag.to_hash
          return hash unless hash.nil?

          {
            response_code: 204,
            message: "There was no feature_flag to include"
          }
        else
          {
            response_code: 204,
            include_predicate: feature_flag.include_predicate,
            message: "Excluded - the include_predicate returned false"
          }
        end
      end
    end
  end
end
