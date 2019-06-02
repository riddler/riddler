module Riddler
  module Visitors
    class NextStep < ::Riddler::Visitor
      attr_reader :journey

      def initialize journey, context
        @journey = journey
        @context = context
        @location = ::Riddler::Location.new
        @next_location = nil
        @next_step = nil
      end

      def accept node
        super
        journey.location = @next_location
        @next_step
      end

      private

      def visit node
        @location.push node
        node.enter @context
        super
        @location.pop
      end

      def terminal node
        @next_step = node
        @next_location = @location.to_s
      end

      def visit_FLOW_STEP node
        visit node.steps.first
        #included_step = node.steps.detect &:include?
        #visit included_step
      end

      def visit_VARIANT_STEP node
        included_step = node.steps.detect { |step| step.include? @context }
        visit included_step
      end
    end
  end
end
