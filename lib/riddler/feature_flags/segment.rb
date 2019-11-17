module Riddler
  module FeatureFlags
    class Segment < ::Riddler::FeatureFlag
      TYPE = "Segment".freeze

      def condition
        definition["condition"]
      end

      def enabled
        Predicator.evaluate condition, context.to_liquid
      end

      def to_hash
        super.merge enabled: enabled
      end
    end
  end
end
