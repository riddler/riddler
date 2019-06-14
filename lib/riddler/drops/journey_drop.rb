module Riddler
  module Drops
    class JourneyDrop < ::Liquid::Drop
      def initialize journey
        @journey = journey
      end

      def id
        @journey.id
      end

      def to_hash
        {
          id: id
        }
      end
    end
  end
end
