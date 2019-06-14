module Riddler
  module Elements

    class Copy < ::Riddler::Element
      def self.type
        "Copy"
      end

      def text
        context.render definition["text"]
      end

      def to_hash
        super.merge text: text
      end
    end

  end
end
