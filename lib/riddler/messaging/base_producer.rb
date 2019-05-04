module Riddler
  module Messaging
    class BaseProducer
      attr_reader :last_message

      def initialize
        @last_message = nil
      end

      def publish _topic, body
        @last_message = body
      end

      private

      def debug *args
        ::Riddler.logger.debug *args
      end

      def info *args
        ::Riddler.logger.info *args
      end
    end
  end
end
