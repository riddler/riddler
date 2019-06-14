module Riddler
  module Concerns
    module Logging
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
