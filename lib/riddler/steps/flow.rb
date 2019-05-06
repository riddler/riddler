module Riddler
  module Steps
    class Flow < ::Riddler::Step
      TYPE = "flow".freeze

      def steps
        @steps ||= definition["steps"].map do |hash|
          ::Riddler::Step.for hash, context
        end
      end

      def included_step
        steps.detect &:include?
      end

      def to_hash
        included_step&.to_hash
      end
    end
  end
end
