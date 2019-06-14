module Riddler
  module Steps
    class LinearFlow < ::Riddler::Step
      TYPE = "LinearFlow".freeze

      def steps
        @steps ||= definition["steps"].map do |hash|
          ::Riddler::Step.for hash, context
        end
      end

      def included_step
        steps.detect &:include?
      end

      def render?
        false
      end

      def to_hash
        included_step&.to_hash
      end
    end
  end
end
