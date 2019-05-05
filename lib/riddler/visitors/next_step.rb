module Riddler
  module Visitors
    class NextStep < ::Riddler::Visitor
      private

      def visit_VARIANT_STEP node
        included_step = node.steps.detect &:include?
        included_step
      end
    end
  end
end
